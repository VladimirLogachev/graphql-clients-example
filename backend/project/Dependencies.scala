import sbt._

object Dependencies {

  lazy val commonDep: Seq[ModuleID] = Seq(
    "dev.zio"               %% "zio"              % Versions.zio,
    "dev.zio"               %% "zio-streams"      % Versions.zio,
    "dev.zio"               %% "zio-interop-cats" % Versions.zioCatsInterop,
    "com.github.pureconfig" %% "pureconfig-core"  % Versions.pureConfig
  ) map (_ % Compile)

  lazy val httpDep: Seq[ModuleID] = Seq(
    "com.github.ghostdogpr" %% "caliban"             % Versions.caliban,
    "com.github.ghostdogpr" %% "caliban-tapir"       % Versions.caliban,
    "com.github.ghostdogpr" %% "caliban-http4s"      % Versions.caliban,
    "org.http4s"            %% "http4s-blaze-server" % Versions.http4s
  ) map (_ % Compile)

  lazy val testDep: Seq[ModuleID] = Seq(
    "dev.zio" %% "zio-test"     % Versions.zio,
    "dev.zio" %% "zio-test-sbt" % Versions.zio
  ) map (_ % Test)
}
