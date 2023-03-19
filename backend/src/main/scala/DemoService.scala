import DemoData.Demo
import zio.*

trait DemoService {
  def getDemo: UIO[Demo]
  def incrementDemo(int: Int): UIO[Demo]
}

object DemoService {
  def getDemo: URIO[DemoService, Demo] =
    ZIO.serviceWithZIO[DemoService](_.getDemo)

  def incrementDemo(int: Int): URIO[DemoService, Demo] =
    ZIO.serviceWithZIO[DemoService](_.incrementDemo(int))
}

case class DemoServiceImpl() extends DemoService {
  def getDemo: UIO[Demo]                 = ZIO.succeed(Demo(int = 42))
  def incrementDemo(int: Int): UIO[Demo] = ZIO.succeed(Demo(int + 1))
}

object DemoServiceImpl {
  val layer: ZLayer[Any, Nothing, DemoService] = ZLayer.succeed(DemoServiceImpl())
}
