module Update exposing (..)
import Model  exposing (..)
import Treeview as T

import Debug

type Msg
  = NoOp
  | TMsg T.Msg

-- type Msg
--   = Change String
--   | Toggle Key
--   | Select Key
--   | Search String
--   | ToggleCheck Bool Bool Key Bool   -- Multiple Cascade Key Value



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  -- case msg of
  --   NoOp ->
      ( model, Cmd.none )
