name := "Prims Algorthm"

version := "1.0"

scalaVersion := "2.10.5"

libraryDependencies ++= Seq(
	"org.apache.spark" %% "spark-core" % "1.6.1",
	"org.apache.spark" %% "spark-graphx" % "1.6.1",
	"com.typesafe.akka" % "akka-actor_2.10" % "2.3.4",
        "com.github.scala-incubator.io" % "scala-io-core_2.9.1" % "0.4.0"

	)

