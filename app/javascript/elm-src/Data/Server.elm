module Data.Server exposing (..)
import Http

-- import Update exposing (..)
-- import Model exposing (..)
import Msg exposing (Msg(..))

get_model : Cmd Msg
get_model =
  Http.send ModelUpdate (Http.getString  "/model/")
