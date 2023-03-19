addCommandAlias("generateGqlSchema", "runMain GenerateGqlSchema")

addCommandAlias(
  "styleCheck",
  "scalafmtSbtCheck; scalafmtCheckAll; scalafixAll --check"
)
addCommandAlias(
  "styleFix",
  "scalafixAll; scalafmtSbt; scalafmtAll"
)

addCommandAlias("dev", "tpolecatDevMode")
addCommandAlias("ci", "tpolecatCiMode")
