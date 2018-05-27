import Html
import Model
import Update exposing (..)
import View
import Init
import Subscriptions
-- import Flags  exposing (..)

main : Program Never Model.Model Msg
main = Html.program
  { init          = Init.dummy
  , update        = update
  , view          = View.main_grid
  , subscriptions = Subscriptions.none
  }
