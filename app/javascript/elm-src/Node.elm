module Node exposing (..)
-- (view, view_notop, update, selection, selected_note_paths)

import Html as H exposing (Html)
import Html.Attributes as HA
import Html.Events as HE
import Model exposing (..)
import Msg   exposing  (..)
import Class

import Tree exposing (Tree, children)

import Node.State exposing (..)
import Node.Filter exposing (..)
import Node.Helper exposing (..)


-- UPDATE

update : NodeMsg -> ItemTree a -> ItemTree a
update nodemsg trunk =
  case nodemsg of
    Selected  key -> select    key trunk
    OpenClose key -> openClose key trunk

select : String -> ItemTree a -> ItemTree a
select key tree =
  Tree.map (toggle_item_selection key) tree


openClose : String -> ItemTree a -> ItemTree a
openClose key tree =
  Tree.map (toggle_item_openClose key) tree

toggle_item_selection : String -> Item a -> Item a
toggle_item_selection key item =
  if key == item.key then
    {item | state = toggle_selection item.state }
  else
    item

toggle_item_openClose : String -> Item a -> Item a
toggle_item_openClose key item =
  if key == item.key then
    {item | state = toggle_openClose item.state }
  else
    item



-- VIEW

-- view_notop : TreeType -> Selection -> Node -> Html Msg
-- view_notop tree selection node =
--     uli (node |> children |> sort |> List.map (view tree selection) )


viewFolder : Folders -> Html Msg
viewFolder node =
  view folderVisible FolderMsg node

viewTag : Selection -> Tags -> Html Msg
viewTag selection node =
  view (tagVisible selection) TagMsg node

viewNote : Selection -> Notes -> Html Msg
viewNote selection node =
  view (noteVisible selection) NoteMsg node

view : (Tree (Item a) -> Bool)
        -> (NodeMsg -> Msg)
        -> Tree (Item a)
        -> Html Msg
view isVisible treeMsg node =
  if isVisible node then
    if isOpened node then
      uli
        ( [item treeMsg node]
            ++ (node
                |> Tree.children
                |> sort
                |> List.map
                    ( view isVisible treeMsg
                    )
               )
        )
    else
      uli [item treeMsg node]
  else
    H.text ""

isOpened : Tree { c | state : { b | opened : a } } -> a
isOpened node =
  node |> Tree.label |> .state |> .opened


item : (NodeMsg -> Msg) -> Tree (Item a) -> Html Msg
item treeMsg node =
  H.span []
  [   H.span
      [ Class.li
      , eventOpenClose treeMsg (Tree.label node)
      ]
      [
        H.span (icon node) []
      ]
  , H.div
      [
      style node
      , eventSelect treeMsg (Tree.label node)
      , class (Tree.label node)
      ]
      [text node]
  ]

eventSelect : (NodeMsg -> Msg) -> Item a -> H.Attribute Msg
eventSelect treeMsg item =
  HE.onClick (treeMsg (Selected item.key))




eventOpenClose : (NodeMsg -> Msg) -> Item a -> H.Attribute Msg
eventOpenClose treeMsg item =
  HE.onClick (treeMsg (OpenClose item.key))


style : a -> H.Attribute msg
style node =
  HA.style []


text : Tree (Item a) -> Html msg
text node =
  node
  |> Tree.label
  |> .name
  |> H.text

class : Item a -> H.Attribute msg
class item =
  HA.classList
  [ ("node", True)
  , ("selected", item.state.selected)
  , ("checked",  item.state.checked)
  , ("opened",   item.state.opened)
  , ("closed",   not item.state.opened)
  , ("disabled", not item.state.enabled)
  , ("hidden",   not item.state.visible)
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

selected_note_paths : Notes -> List String
selected_note_paths tree =
  Tree.flatten tree
  |> List.filter isSelected
  |> List.map .resource


isSelected item =
  item |> .state |> .selected


  -- selected_nodes tree
  -- |> List.map .resource
  -- ["zwo", "drei", "vier"]
