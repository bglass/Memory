module Tree exposing (..)

import Html exposing (Html)
import Element exposing (Element)
import Json.Decode as JD

import Treeview as T
-- import View.Tree.Style as VTS

import Msg exposing (..)

-- MODEL

type alias Model = T.Model
type alias Node  = T.Node

-- INIT
defaultOptions : T.Options
defaultOptions = T.Options "None" True True False True False

-- UPDATE

update : T.Msg -> T.Model -> T.Model
update msg model =
  T.update msg model
  -- [T.Node "F1" "P1" defaultOptions (Just [])]

decoder : JD.Decoder T.Node
decoder =
  JD.map4 T.Node
    ( JD.field "id"        JD.string )
    ( JD.field "name"      JD.string )
    ( JD.succeed      defaultOptions )
    ( JD.field "children"  <|
      JD.maybe (
        JD.list (JD.lazy (\_ -> decoder )))
    )


-- VIEW

view : T.Model -> (T.Msg -> msg) -> Element style variation msg
view top parentmsg =
  Element.html
  ( Html.div []
    [ Html.map parentmsg (T.view config top)
    ]
  )

style : T.Style
style =
  T.Style "folder" ("folder yellow", "folder-open yellow") ""

config : T.Config
config = T.default [style]
