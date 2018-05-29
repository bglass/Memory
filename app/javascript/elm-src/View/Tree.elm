module View.Tree exposing (folders)

import Html exposing (Html)
import Element exposing (..)
import Treeview as T

import View.Style exposing (..)
import Model exposing (..)
import Update exposing (..)

import Data.TreeDummy1 as D



folders : Folder -> Element style variation Msg
folders top =
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
config = T.default D.styles

tNodes : List Folder -> List T.Node
tNodes records =
  List.map tNode records

tNode : Folder -> T.Node
tNode record =
  T.node
    (f_name record)
    (f_name record)
    "folder"
    True
    (Just (f_children record))

f_children : Folder -> List T.Node
f_children item = tNodes (getFolder item .children)



f_name     (Folder content) = content.name

getFolder (Folder content) get_field =
  content |> get_field
getNote   (Note content) get_field =
  content |> get_field
getTag    (Tag content) get_field =
  content |> get_field
