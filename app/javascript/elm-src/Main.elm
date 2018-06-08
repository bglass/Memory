module Main exposing (main)

import Html exposing (Html )
-- import Http
import Subscriptions

-- import Flags exposing (..)

import Init
import Model exposing  (Model)
import View  exposing  (view)
import Update
import Msg   exposing  (Msg(..))

main : Program Never Model Msg
main = Html.program
  { init          = Init.load
  , update        = Update.update
  , view          = view
  , subscriptions = Subscriptions.none
  }
