/*
 * Prims Algorthm
 * CS4310
 */
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.SparkConf

class Node(id: Int) {
  var edges = List[Edge]()

  def addEdge(other: Node, weight: Int) = {
    val edge = new Edge(this, other, weight)
    edges = edge :: edges
    edge
  }

  override def toString() = id.toString
}

class Edge(val from: Node, val to: Node, val weight: Int) extends Ordered[Edge] {
  // Inverse ordering; should really be external.
  def compare(that: Edge) = that.weight compare weight
  override def toString() = from + "," + to + "," + weight
}

object primsAlgo {

  def main(args: Array[String]) {
    val logFile = "/root/cluster-computing/demos/primsalgo/RawData.csv" // Should be some file on your system
    val conf = new SparkConf().setAppName("Prims Algorthm")
    val sc = new SparkContext(conf)
    val logData = sc.textFile(logFile, 2).cache()


    var count = 0
    val rowArray = readCSV(logFile)
    val colArray = rowArray.transpose
    val nodesList = (colArray(0).toList ++ colArray(1).toList).distinct
    var nodeStruct = new Array[Node](nodesList.length + 1)

    while (count < nodesList.length + 1) {

      nodeStruct(count) = new Node(count)
      count = count + 1
    }
    count = 0

    while (count < colArray(0).length) {
      nodeStruct(rowArray(count)(0).toInt).addEdge(nodeStruct(rowArray(count)(1).toInt), rowArray(count)(2).toInt)
      nodeStruct(rowArray(count)(1).toInt).addEdge(nodeStruct(rowArray(count)(0).toInt), rowArray(count)(2).toInt)
      count = count + 1
    }
    count = 0

    val graph = nodeStruct.toList

    // generateMST(graph).sortWith(_ < _).foreach(println)
    val readLines = generateMST(graph).sortWith(_ < _).toList

    readLines.length
    var totalLength = 0
    while (count < readLines.length) {
      val myLine = readLines(count).toString().split(",")
      totalLength = totalLength + myLine.last.toInt
      println(myLine(0) + " <--> " + myLine(1) + "    (" + myLine(2) + ")")
      count = count + 1
    }
    println(totalLength)

  }

  def readCSV(fileName: String): Array[Array[Double]] = {
    val bufferedSource = io.Source.fromFile(fileName)
    var matrix: Array[Array[Double]] = Array.empty
    for (line <- bufferedSource.getLines) {
      val cols = line.split(",").map(_.trim.toDouble)
      matrix = matrix :+ cols
    }
    bufferedSource.close
    return matrix
  }

  // Prim's algorithm:
  //   * Choose a random node.
  //   * Place edges from that node in priority queue.
  //   * While queue not empty:
  //   *   pop highest weighted edge
  //   *   if end-point in already-included set, continue
  //   *   else:
  //   *     add edge to edge-set
  //   *     add node to node-set
  //   *     add edges from new node to queue

  def generateMST(graph: List[Node]): List[Edge] = {
    import scala.util.Random

    val startNode = graph(Random.nextInt(graph.length))

    var mst_nodes = List(startNode)
    var mst_edges = List[Edge]()

    val pq = new scala.collection.mutable.PriorityQueue[Edge]

    startNode.edges.foreach(e => pq.enqueue(e))

    while (!pq.isEmpty) {
      val edge = pq.dequeue

      if (!(mst_nodes contains edge.to)) {
        mst_nodes = edge.to :: mst_nodes
        mst_edges = edge :: mst_edges

        edge.to.edges.foreach(e => pq.enqueue(e))
      }
    }

    mst_edges

  }
}