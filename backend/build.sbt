import Dependencies._

lazy val root = project
  .in(file("."))
  .settings(settings)

lazy val settings = Seq(
  name              := "theroadtaken",
  version           := "0.1.0-SNAPSHOT",
  scalaVersion      := "3.2.2",
  semanticdbEnabled := true,
  semanticdbVersion := scalafixSemanticdb.revision,
  libraryDependencies ++= commonDep ++ httpDep ++ testDep,
  run / fork := true,
  testFrameworks += new TestFramework("zio.test.sbt.ZTestFramework")
)
