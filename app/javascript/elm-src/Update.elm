module Update exposing (..)

import Http

import Model  exposing (..)
import Treeview as T
import Data.Decode as DD

type Msg
  = NoOp
  | TMsg T.Msg
  | FolderUpdate (Result Http.Error String)

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

    FolderUpdate (Ok data) ->
      ({model | folders = DD.folders data }, Cmd.none)

    FolderUpdate (Err error) ->
      ({model | errmsg = toString error}, Cmd.none )


      --
      --
      --
      --
      -- -- let personAddress = person.address in { person | address = { personAddress | city = "Madrid" } }
      -- let mdl = { model | search  = { model.search   | re_book = error } }
      -- in (mdl, Cmd.none)
