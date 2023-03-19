import caliban.Http4sAdapter
import org.http4s.blaze.server.BlazeServerBuilder
import org.http4s.implicits.*
import org.http4s.server.Router
import org.http4s.server.middleware.CORS
import zio.*
import zio.interop.catz.*

object Main extends ZIOAppDefault {

  type DemoTask[A] = RIO[DemoService, A]

  def run =
    ZIO
      .runtime[DemoService]
      .flatMap(implicit runtime =>
        for {
          interpreter <- DemoApi.api.interpreter
          _ <- BlazeServerBuilder[DemoTask]
            .bindHttp(8088, "localhost")
            .withHttpWebSocketApp(wsBuilder =>
              Router[DemoTask](
                "/api/graphql" -> CORS.policy(Http4sAdapter.makeHttpService(interpreter)),
                "/ws/graphql"  -> CORS.policy(Http4sAdapter.makeWebSocketService(wsBuilder, interpreter))
              ).orNotFound
            )
            .resource
            .toManagedZIO
            .useForever
        } yield ()
      )
      .provideLayer(DemoServiceImpl.layer)
      .exitCode
}
