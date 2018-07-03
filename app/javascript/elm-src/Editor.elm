module Editor exposing (..)

import Msg exposing (..)
import Json.Decode as JD
import Html.Events as HE
import Html exposing (Attribute)
import Model exposing (..)
import Char

onKeyUp : String -> Attribute Msg
onKeyUp article_key =
  HE.on "keyup"
  ( JD.map2 Edit
    ( JD.succeed article_key)
    keypress
  )


update : String -> KeyPress -> String
update source key =
  if String.length key.key  == 1 then
    key.key ++ source
  else
    source





keypress : JD.Decoder KeyPress
keypress = JD.map2 KeyPress
  ( JD.field "keyCode"    JD.int)
  ( JD.field "key"        JD.string)
