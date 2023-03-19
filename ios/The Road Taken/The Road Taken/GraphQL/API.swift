// This file was auto-generated using maticzav/swift-graphql. DO NOT EDIT MANUALLY!
import Foundation
import GraphQL
import SwiftGraphQL

// MARK: - Operations
public enum Operations {}
extension Objects.Queries: GraphQLHttpOperation {
  public static var operation: GraphQLOperationKind { .query }
}
extension Objects.Mutations: GraphQLHttpOperation {
  public static var operation: GraphQLOperationKind { .mutation }
}
extension Objects.Subscriptions: GraphQLWebSocketOperation {
  public static var operation: GraphQLOperationKind { .subscription }
}

// MARK: - Objects
public enum Objects {}
extension Objects {
  public struct Demo {}
}

extension Fields where TypeLock == Objects.Demo {

  public func int() throws -> Int {
    let field = GraphQLField.leaf(
      field: "int",
      parent: "Demo",
      arguments: []
    )
    self.__select(field)

    switch self.__state {
    case .decoding:
      return try self.__decode(field: field.alias!) { try Int(from: $0) }
    case .selecting:
      return Int.mockValue
    }
  }
}
extension Selection where T == Never, TypeLock == Never {
  public typealias Demo<T> = Selection<T, Objects.Demo>
}
extension Objects {
  public struct Mutations {}
}

extension Fields where TypeLock == Objects.Mutations {

  public func increment<T>(
    demoInput: InputObjects.DemoInputInput, selection: Selection<T, Objects.Demo>
  ) throws -> T {
    let field = GraphQLField.composite(
      field: "increment",
      parent: "Mutations",
      type: "Demo",
      arguments: [Argument(name: "demoInput", type: "DemoInputInput!", value: demoInput)],
      selection: selection.__selection()
    )
    self.__select(field)

    switch self.__state {
    case .decoding:
      return try self.__decode(field: field.alias!) { try selection.__decode(data: $0) }
    case .selecting:
      return try selection.__mock()
    }
  }
}
extension Selection where T == Never, TypeLock == Never {
  public typealias Mutations<T> = Selection<T, Objects.Mutations>
}
extension Objects {
  public struct Queries {}
}

extension Fields where TypeLock == Objects.Queries {
  /// Return demo

  public func demo<T>(selection: Selection<T, Objects.Demo>) throws -> T {
    let field = GraphQLField.composite(
      field: "demo",
      parent: "Queries",
      type: "Demo",
      arguments: [],
      selection: selection.__selection()
    )
    self.__select(field)

    switch self.__state {
    case .decoding:
      return try self.__decode(field: field.alias!) { try selection.__decode(data: $0) }
    case .selecting:
      return try selection.__mock()
    }
  }
}
extension Selection where T == Never, TypeLock == Never {
  public typealias Queries<T> = Selection<T, Objects.Queries>
}
extension Objects {
  public struct Subscriptions {}
}

extension Fields where TypeLock == Objects.Subscriptions {

  public func demo<T>(selection: Selection<T, Objects.Demo>) throws -> T {
    let field = GraphQLField.composite(
      field: "demo",
      parent: "Subscriptions",
      type: "Demo",
      arguments: [],
      selection: selection.__selection()
    )
    self.__select(field)

    switch self.__state {
    case .decoding:
      return try self.__decode(field: field.alias!) { try selection.__decode(data: $0) }
    case .selecting:
      return try selection.__mock()
    }
  }
}

extension Objects.Demo {

  public static func int() -> Selection<Int, Objects.Demo> {
    Selection<Int, Objects.Demo> {
      try $0.int()
    }
  }
}
extension Objects.Mutations {

  public static func increment<T>(
    demoInput: InputObjects.DemoInputInput, selection: Selection<T, Objects.Demo>
  ) -> Selection<T, Objects.Mutations> {
    Selection<T, Objects.Mutations> {
      try $0.increment(demoInput: demoInput, selection: selection)
    }
  }
}
extension Objects.Queries {
  /// Return demo

  public static func demo<T>(selection: Selection<T, Objects.Demo>) -> Selection<T, Objects.Queries>
  {
    Selection<T, Objects.Queries> {
      try $0.demo(selection: selection)
    }
  }
}
extension Objects.Subscriptions {

  public static func demo<T>(selection: Selection<T, Objects.Demo>) -> Selection<
    T, Objects.Subscriptions
  > {
    Selection<T, Objects.Subscriptions> {
      try $0.demo(selection: selection)
    }
  }
}

// MARK: - Interfaces
public enum Interfaces {}

// MARK: - Unions
public enum Unions {}

// MARK: - Enums
public enum Enums {}

// MARK: - Input Objects

/// Utility pointer to InputObjects.
public typealias Inputs = InputObjects

public enum InputObjects {}
extension InputObjects {
  public struct DemoInputInput: Encodable, Hashable {

    public var int: Int

    public init(
      int: Int
    ) {
      self.int = int
    }

    public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(int, forKey: .int)
    }

    public enum CodingKeys: String, CodingKey {
      case int = "int"
    }
  }
}