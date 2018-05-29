module View.Tree.Folder exposing (view)

import Html exposing (Html)
import Element exposing (..)
import Treeview as T

import Model exposing (..)
import Update exposing (..)

import View.Tree.Style as VTS



view : Folder -> Element style variation Msg
view top =
  html (treeview
    (f_children top)
    -- [tNode top]
  )


treeview : T.Model -> Html Msg
treeview data =
  Html.div []
    [ Html.map TMsg (T.view config data)
    ]

config : T.Config
config = T.default VTS.styles

tNodes : List Folder -> List T.Node
tNodes records =
  List.map tNode records

tNode : Folder -> T.Node
tNode record =
  T.Node
    (f_key     record)
    (f_name    record)
    (f_options record)
    (Just (f_children record))



f_children : Folder -> List T.Node
f_children (Folder content) = tNodes content.children

f_name : Folder -> String
f_name     (Folder content) = content.name

f_key : Folder -> String
f_key     (Folder content) = content.name

f_options : Folder -> Options
f_options     (Folder content) = content.options
