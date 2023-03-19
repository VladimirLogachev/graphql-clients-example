# Backend

## Prerequisites

- `sbt`
- Docker
- docker-compose `v2` or higher (Note for macOS: enable `Use Docker Compose V2` in Docker Preferences)
- OpenJDK 11 or above
- GraphQL Playground
  ```shell
  brew install --cask graphql-playground
  ```
- [graphqurl](https://github.com/hasura/graphqurl)

## Setting up

### Scalafmt Editor support

- [VS Code][vscode]
- [Intellij IDEA][intellij]

[vscode]: https://scalameta.org/metals/docs/editors/vscode/
[intellij]: https://scalameta.org/scalafmt/docs/installation.html#intellij

## Usage

- Start Postgres in docker container

  ```sh
  docker compose up -Vd --wait postgres
  ```

- Fill db by demo data

  ```sh
  sbt dev ???
  ```

- Run

  ```sh
  sbt dev "runMain Main"
  ```

- Run in live reload mode

  ```sh
  sbt dev ~reStart
  ```

- When done, remove docker containers, networks and volumes

  ```sh
  docker compose down -v
  ```

- Clean build artifacts and recompile (just in case)

  ```sh
  sbt clean compile
  ```

- Run tests

  ```sh
  sbt test
  ```

- Generate graphql schema

  ```sh
  sbt dev generateGqlSchema
  ```

- Check for dependency updates (just in case)

  ```sh
    sbt dev dependencyUpdates
  ```

### Scalafix

- `sbt scalafix` – run linter, check all files, fail on warnings

### Tpolecat

There are several modes: `dev`, `ci`, `release`. In `dev` mode "fatal warnings" are disabled, so you will be able to see
warnings, but they won't prevent code from compiling.

- You can change tpolecat plugin mode in sbt interactively, e.g: `sbt ci` or `sbt dev`
- You can prepend your commands with mode, e.g: `sbt ci test` or `sbt dev test`
- You can set mode via env variable, e.g: `SBT_TPOLECAT_DEV=true sbt compile`, `SBT_TPOLECAT_CI=true sbt compile`,
  or `SBT_TPOLECAT_RELEASE=true sbt compile`

### Additional resources

[Setting up debugger in Intellij IDEA](/docs/intellij-idea-setup.md)

## GraphQL API docs

- GraphQL Playground app
- Select "URL Endpoint"
- Enter `http://localhost:8088/api/graphql`
- Use "Schema" tab to read schema

- `garphqurl` CLI

### Example mutation

```graphql
mutation {
  increment(demoInput: { int: 42 }) {
    int
  }
}
```
