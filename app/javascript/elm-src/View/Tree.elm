module View.Tree exposing (view)

import Html
import Element exposing (..)
import Treeview as T

import View.Style exposing (..)
import Model exposing (..)
import Update exposing (..)

import Data.TreeDummy1 as D


view records =
  html (treeview (nodes records) )

treeview data =
  Html.div []
    [ Html.map TMsg (T.view config data)
    ]

config : T.Config
config = T.default D.styles

names records =
  List.map .name records

nodes records =
  List.map node records

node record =
  T.node record.name record.name "folder" True Nothing
