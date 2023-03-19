module Main exposing (main)

import Api.InputObject exposing (DemoInputInput)
import Api.Mutation as Mutation exposing (IncrementRequiredArguments)
import Api.Object.Demo as Demo
import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import Graphql.Http as Http
import Graphql.SelectionSet as SelectionSet
import RemoteData exposing (RemoteData(..))
import Task exposing (Task)


graphqlUrl : String
graphqlUrl =
    "http://localhost:8088/api/graphql"


type alias GraphqlTask t =
    Task (Http.Error ()) t


{-| elm-graphql allows also to get some "possibly recovered data",
but we don't care, that's why we have a Unit type as a parameter to Error.
-}
type alias GraphqlResponse a =
    RemoteData (Http.Error ()) a


type alias Demo =
    { int : Int }


increment : DemoInputInput -> GraphqlTask Demo
increment =
    IncrementRequiredArguments
        >> (\args -> Mutation.increment args (SelectionSet.map Demo Demo.int))
        >> Http.mutationRequest graphqlUrl
        >> Http.toTask
        >> Task.mapError (Http.mapError <| always ())


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = Element.layout [ Font.family [ Font.typeface "Open Sans", Font.sansSerif ] ] << view
        , subscriptions = always Sub.none
        }


type alias Model =
    { textInput : String
    , incrementResponse : GraphqlResponse String
    }


init : flags -> ( Model, Cmd Msg )
init _ =
    ( { textInput = "?"
      , incrementResponse = NotAsked
      }
    , Cmd.none
    )


type Msg
    = IncrementClicked
    | GotIncrementResponse (GraphqlResponse Demo)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        IncrementClicked ->
            ( { model | incrementResponse = Loading }
            , increment { int = 42 }
                |> Task.attempt (RemoteData.fromResult >> GotIncrementResponse)
            )

        GotIncrementResponse res ->
            ( { model | textInput = RemoteData.unwrap "error" (.int >> String.fromInt) res }
            , Cmd.none
            )


view : Model -> Element Msg
view model =
    column [ padding 40, spacing 40 ]
        [ el [ Region.heading 1, Font.size 30, Font.bold ] <| text "The Road Taken"
        , text <| "Result: " ++ model.textInput
        , Input.button
            [ Background.color (Element.rgb255 0 0 0)
            , Font.color (Element.rgb255 255 255 255)
            , padding 20
            , Border.rounded 5
            ]
            { onPress = Just IncrementClicked
            , label = text "Increment 42 via GraphQL"
            }
        ]
