import org.apache.log4j.Level
import org.apache.log4j.Logger
import org.apache.spark.SparkConf
import org.apache.spark.SparkContext
import org.apache.spark.graphx.Edge
import org.apache.spark.graphx.EdgeTriplet
import org.apache.spark.graphx.Graph
import org.apache.spark.graphx.Graph.graphToGraphOps
import org.apache.spark.graphx.VertexId
import org.apache.spark.rdd.RDD
import org.apache.spark.rdd.RDD.rddToPairRDDFunctions

object ParallelPrims {
  Logger.getLogger("org").setLevel(Level.OFF)
  Logger.getLogger("akka").setLevel(Level.OFF)
  var total = 0
  def main(args: Array[String]) {
    val conf = new SparkConf().setAppName("Parallel Prims")
    val sc = new SparkContext(conf)
    val logFile = "/root/cluster-computing/demos/graph-generator/NodeData.txt"

    val logData = sc.textFile(logFile, 2).cache()
    // Splitting off header node
    val headerAndRows = logData.map(line => line.split(",").map(_.trim))
    val header = headerAndRows.first
    val data = headerAndRows.filter(_(0) != header(0))
    // Parse number of Nodes and Edges from header
    val numNodes = header(0).toInt
    val numEdges = header(1).toInt

    val vertexArray = new Array[(Long, String)](numNodes)

    var edgeArray = new Array[Edge[Int]](numEdges)
    // Create vertex array
    var count = 0
    for (count <- 0 to numNodes - 1) {
      vertexArray(count) = (count.toLong + 1, ("v" + (count + 1)).toString())
    }
    count = 0
    val rrdarr = data.take(data.count.toInt)
    // Create edge array
    for (count <- 0 to (numEdges - 1)) {
      val line = rrdarr(count)
      val cols = line.toList
      val edge = Edge(cols(0).toLong, cols(1).toLong, cols(2).toInt)
      edgeArray(count) = Edge(cols(0).toLong, cols(1).toLong, cols(2).toInt)
    }
    // Creating graphx graph
    val vertexRDD: RDD[(Long, (String))] = sc.parallelize(vertexArray)
    val edgeRDD: RDD[Edge[Int]] = sc.parallelize(edgeArray)

    var graph: Graph[String, Int] = Graph(vertexRDD, edgeRDD)

    //   graph.triplets.take(6).foreach(println)

    // just empty RDD for MST
    var MST = sc.parallelize(Array[EdgeTriplet[String, Int]]())

    // pick random vertex from graph
    var Vt: RDD[VertexId] = sc.parallelize(Array(graph.pickRandomVertex))

    // do until all vertices is in Vt set 
    val vcount = graph.vertices.count
    while (Vt.count < vcount) {

      // rdd to make inner joins
      val hVt = Vt.map(x => (x, x))

      // add key to make inner join
      val bySrc = graph.triplets.map(triplet => (triplet.srcId, triplet))

      // add key to make inner join
      val byDst = graph.triplets.map(triplet => (triplet.dstId, triplet))

      // all triplet where source vertex is in Vt
      val bySrcJoined = bySrc.join(hVt).map(_._2._1)

      // all triplet where destinaiton vertex is in Vt
      val byDstJoined = byDst.join(hVt).map(_._2._1)

      // sum previous two rdds and substract all triplets where both source and destination vertex in Vt
      val candidates = bySrcJoined.union(byDstJoined).subtract(byDstJoined.intersection(bySrcJoined))

      // find triplet with least weight
      val triplet = candidates.sortBy(triplet => triplet.attr).first

      // add triplet to MST 
      MST = MST.union(sc.parallelize(Array(triplet)))

      // find out whether we should add source or destinaiton vertex to Vt
      if (!Vt.filter(x => x == triplet.srcId).isEmpty) {
        Vt = Vt.union(sc.parallelize(Array(triplet.dstId)))
      } else {
        Vt = Vt.union(sc.parallelize(Array(triplet.srcId)))
      }
    }

    // final minimum spanning tree
    MST.collect.foreach {
      p =>
        println(p.srcId + "<--->" + p.dstId + " " + (p.attr))
    }

    val accum = sc.accumulator(0, "My Accumulator")
    //sc.parallelize(MST.collect()).foreach(x => accum += x)
    val total = MST.map{case(a) =>
      a.attr.toDouble
    }.collect
    
    println(total.reduceLeft{ _ + _ })
    
  }

}