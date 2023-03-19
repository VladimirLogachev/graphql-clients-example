val sbtTpolecat = "0.4.2"
val sbtScalafix = "0.10.4"
val sbtScalafmt = "2.5.0"

addSbtPlugin("org.scalameta"             % "sbt-scalafmt" % sbtScalafmt)
addSbtPlugin("ch.epfl.scala"             % "sbt-scalafix" % sbtScalafix)
addSbtPlugin("io.github.davidgregory084" % "sbt-tpolecat" % sbtTpolecat)

//addDependencyTreePlugin
// sbt dependencyTree

//addSbtPlugin("com.github.cb372" % "sbt-explicit-dependencies" % "0.2.16")
// sbt undeclaredCompileDependencies
// sbt unusedCompileDependencies
