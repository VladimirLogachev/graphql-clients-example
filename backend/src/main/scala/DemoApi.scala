import DemoData.{Demo, DemoArgs, DemoInput}
import caliban.GraphQL.graphQL
import caliban.schema.Annotations.*
import caliban.schema.{GenericSchema, Schema}
import caliban.wrappers.Wrappers.*
import caliban.{GraphQL, RootResolver}
import zio.stream.ZStream
import zio.*

import scala.language.postfixOps

object DemoApi extends GenericSchema[DemoService] {

  case class Queries(
      @GQLDescription("Return demo")
      demo: URIO[DemoService, Demo]
  )
  case class Mutations(increment: DemoArgs => URIO[DemoService, Demo])
  case class Subscriptions(demo: ZStream[DemoService, Nothing, Demo])

  implicit val demoSchema: Schema[Any, Demo]           = Schema.gen
  implicit val demoArgsSchema: Schema[Any, DemoArgs]   = Schema.gen
  implicit val demoInputSchema: Schema[Any, DemoInput] = Schema.gen

  val api: GraphQL[DemoService] =
    graphQL[DemoService, Queries, Mutations, Subscriptions](
      RootResolver(
        Queries(demo = DemoService.getDemo),
        Mutations(increment = x => DemoService.incrementDemo(x.demoInput.int)),
        Subscriptions(demo = ZStream.succeed(???))
      )
    ) @@
      maxFields(200) @@               // query analyzer that limit query fields
      maxDepth(30) @@                 // query analyzer that limit query depth
      timeout(3 seconds) @@           // wrapper that fails slow queries
      printSlowQueries(500 millis) @@ // wrapper that logs slow queries
      printErrors                     // wrapper that logs errors

}
