module View.Click exposing (frame)
import Html exposing (..)
import Html.Attributes exposing (..)

frame =
  div []
    [ button1 ]

button1 =
  button [ ] [ text "Ist das genug?" ]
