module Update exposing (..)

import Http

import Model  exposing (..)
import Treeview as T
import Data.Decode as DD

type Msg
  = NoOp
  | TMsg T.Msg
  | ModelUpdate (Result Http.Error String)

-- type Msg
--   = Change String
--   | Toggle Key
--   | Select Key
--   | Search String
--   | ToggleCheck Bool Bool Key Bool   -- Multiple Cascade Key Value



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
      ( model, Cmd.none )
    TMsg _ ->
      ( model, Cmd.none )

    ModelUpdate (Ok data) ->
      let
        result = DD.model data
      in
        case result of
          Ok decoded ->
            ( decoded, Cmd.none )
          Err error ->
            ( {model | errmsg = format_err error}, Cmd.none )
    ModelUpdate (Err error) ->
      ( {model | errmsg = format_err error}, Cmd.none )


format_err : a -> String
format_err error =
  "(EE) " ++ (toString error)
