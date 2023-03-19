import caliban.Http4sAdapter
import org.http4s.blaze.server.BlazeServerBuilder
import org.http4s.implicits.*
import org.http4s.server.Router
import org.http4s.server.middleware.CORS
import zio.*
import zio.interop.catz.*
import zio.stream.{ZSink, ZStream}

import java.io.File
import java.nio.file.Paths
import scala.io.Source

object GenerateGqlSchema extends ZIOAppDefault {

  private def saveSchema: Task[Unit] =
    ZStream
      .fromIterable(DemoApi.api.render)
      .map(value => value.toByte)
      .run(ZSink.fromFile(File("../graphql-schema/schema.gql")))
      .unit
      .zipRight(Console.printLine("Successfully generated graphql schema"))

  def run: UIO[ExitCode] =
    saveSchema
      .tapError(Console.printLine(_))
      .exitCode
}
