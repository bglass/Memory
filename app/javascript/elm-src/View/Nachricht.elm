module View.Nachricht exposing (frame)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model  exposing (..)

frame model =
  div []
    [ text1 model ]

text1 model =
  text ("Hallo alter " ++ model.atext ++ "! Wie geht's?")
