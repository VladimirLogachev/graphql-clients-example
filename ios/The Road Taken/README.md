# iOS

## codegen

- Install codegen

  ```sh
  brew tap maticzav/swift-graphql https://github.com/maticzav/swift-graphql.git
  brew install SwiftGraphQL
  ```

- Run codegen (from the `ios` directory):

  - SDL not supported 💩
  - JSON is supposed to be supported 🤎
  - JSON from endpoint is supported 🤎

  ```sh
  swift-graphql http://localhost:8088/api/graphql -o The\ Road\ Taken/The\ Road\ Taken/GraphQL/API.swift
  ```
