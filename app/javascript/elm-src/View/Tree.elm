module View.Tree exposing (view)

import Html exposing (Html)
import Element exposing (..)
import Treeview as T

import View.Style exposing (..)
import Model exposing (..)
import Update exposing (..)

import Data.TreeDummy1 as D



view : a -> Element style variation Msg
view top =
  -- html (treeview (nodes top.children) )
  text (toString top)

-- treeview : T.Model -> Html Msg
-- treeview data =
--   Html.div []
--     [ Html.map TMsg (T.view config data)
--     ]
--
-- config : T.Config
-- config = T.default D.styles
--
-- names : List a -> List String
-- names records =
--   List.map .name records
--
-- nodes : List a -> List T.Node
-- nodes records =
--   List.map node records
--
-- node : a -> T.Node
-- node record =
--   T.node
--     record.name
--     record.name
--     "folder"
--     True
--     Nothing
