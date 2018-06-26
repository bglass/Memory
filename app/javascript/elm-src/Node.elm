module Node exposing (..)
-- (view, view_notop, update, selection, selected_note_paths)

import Html as H exposing (Html)
import Html.Attributes as HA
import Html.Events as HE
import Model exposing (..)
import Msg   exposing  (..)
import Class

import Tree exposing (Tree, children)


-- import Node.State exposing (..)
import Node.Filter exposing (..)
import Node.Helper exposing (..)


-- UPDATE

-- update : NodeMsg -> Node -> Node
-- update nodemsg trunk =
--   case nodemsg of
--     Selected  key -> select    key trunk
--     OpenClose key -> openClose key trunk
--
-- select : String -> Node -> Node
-- select key node =
--   if node.key == key then
--     { node | state = toggle_selection node.state }
--   else
--     { node | children = children_each (select key) node }
--
-- openClose : String -> Node -> Node
-- openClose key node =
--   if node.key == key then
--     { node | state = toggle_openClose node.state }
--   else
--     { node | children = children_each (openClose key) node }

-- VIEW

-- view_notop : TreeType -> Selection -> Node -> Html Msg
-- view_notop tree selection node =
--     uli (node |> children |> sort |> List.map (view tree selection) )


viewFolder : Folders -> Html Msg
viewFolder node =
  view folderVisible node

viewTag : Selection -> Tags -> Html Msg
viewTag selection node =
  view (tagVisible selection) node

viewNote : Selection -> Notes -> Html Msg
viewNote selection node =
  view (noteVisible selection) node


view isVisible node =
  if isVisible node then
    if isOpened node then
      uli
        ( [item node]
            ++ (node
                |> Tree.children
                |> sort
                |> List.map
                    ( view isVisible
                    )
               )
        )
    else
      uli [item node]
  else
    H.text ""


isOpened node =
  -- node |> Tree.label |> .state |> .opened
  True


-- item : TreeType -> Tree (Item a) -> Html Msg
item node =
  H.span []
  [   H.span
      [ Class.li
      -- , eventOpenClose tree node
      ]
      [
        H.span (icon node) []
      ]
  , H.div
      [
      -- style node
      -- , eventSelect tree node
      -- , class node
      ]
      [text node]
  ]
--
-- eventSelect : TreeType -> Node -> H.Attribute Msg
-- eventSelect tree node =
--   HE.onClick ((treeMsg tree) (Selected node.key))
--
-- eventOpenClose : TreeType -> Node -> H.Attribute Msg
-- eventOpenClose tree node =
--   HE.onClick ((treeMsg tree) (OpenClose node.key))
--
--
-- style : Node -> H.Attribute msg
style node =
  HA.style []


text : Tree (Item a) -> Html msg
text node =
  node
  |> Tree.label
  |> .name
  |> H.text

class : Item a -> H.Attribute msg
class node =
  HA.classList
  [ ("node", True)
  , ("selected", node.state.selected)
  , ("checked",  node.state.checked)
  , ("opened",   node.state.opened)
  , ("closed",   not node.state.opened)
  , ("disabled", not node.state.enabled)
  , ("hidden",   not node.state.visible)
  ]

uli : List (Html msg) -> Html msg
uli items =
  H.ul Class.ul
    [ H.li [] items
    ]

icon : Tree (Item a) -> List (H.Attribute msg)
icon node =
  if List.isEmpty (node |> children) then
    Class.nodeChildless
  else if (Tree.label node |> .state |> .opened) then
    Class.nodeOpened
  else
    Class.nodeClosed

selection : Model -> Selection
selection model = { folder_paths = folder_paths model.folder
                  , note_tags    = note_tags    model
                  , tag_names    = tag_names    model
                  }

-- selected_note_paths : Node -> List String
-- selected_note_paths node =
--   -- selected_nodes node
--   -- |> List.map .resource
--   ["eins", "zwei", "drei"]
