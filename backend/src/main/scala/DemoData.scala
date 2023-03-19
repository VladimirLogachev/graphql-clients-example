import caliban.schema.Annotations.GQLDescription

object DemoData {
  @GQLDescription("Just a Demo object")
  case class Demo(int: Int)

  @GQLDescription("Just a Demo input object")
  case class DemoInput(int: Int)

  /** The list of DemoArgs constructor arguments becomes a list of mutation arguments. This example illustrates how to
    * require specific product type as an argument
    */
  case class DemoArgs(demoInput: DemoInput)
}
