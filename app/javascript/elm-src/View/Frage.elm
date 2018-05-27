module View.Frage exposing (frame)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

import Model exposing (..)
import Update exposing (..)

frame =
  div []
    [ input1 ]

input1 =
  -- input [ type_ "text" ] []
  input [ type_ "text", onInput Change ] []
