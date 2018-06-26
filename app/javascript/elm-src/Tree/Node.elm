module Tree.Node exposing (..)
-- (view, view_notop, update, selection, selected_note_paths)

import Html as H exposing (Html)
import Html.Attributes as HA
import Model exposing (..)
import Msg   exposing  (..)
import Tree.Leaf as Leaf

import Tree exposing (Tree, children)

import Tree.Filter exposing (..)
import Tree.Helper exposing (..)


-- UPDATE

update : NodeMsg -> ItemTree a -> ItemTree a
update nodemsg trunk =
  case nodemsg of
    Selected  key -> select    key trunk
    OpenClose key -> openClose key trunk

select : String -> ItemTree a -> ItemTree a
select key tree =
  Tree.map (Leaf.toggle_selection key) tree


openClose : String -> ItemTree a -> ItemTree a
openClose key tree =
  Tree.map (Leaf.toggle_openClose key) tree

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
      uli
      ( [Leaf.view treeMsg (icon node) (Tree.label node)]
        ++ (branches isVisible treeMsg node)
      )
  else
    H.text ""

branches isVisible treeMsg node =
    if (isOpened node) then
      node
      |> Tree.children
      |> sort
      |> List.map ( view isVisible treeMsg )
    else
      []

isOpened : Tree { c | state : { b | opened : a } } -> a
isOpened node =
  node |> Tree.label |> .state |> .opened



uli : List (Html msg) -> Html msg
uli items =
  H.ul Leaf.ul
    [ H.li [] items
    ]

icon : ItemTree a -> List (H.Attribute msg)
icon node =
  if List.isEmpty (node |> children) then
    Leaf.nodeChildless
  else if (Tree.label node |> .state |> .opened) then
    Leaf.nodeOpened
  else
    Leaf.nodeClosed

selection : Model -> Selection
selection model = { folder_paths = folder_paths model.folder
                  , note_tags    = note_tags    model
                  , tag_names    = tag_names    model
                  }

selected_note_paths : Notes -> List String
selected_note_paths tree =
  Tree.flatten tree
  |> List.filter Leaf.isSelected
  |> List.map .resource
