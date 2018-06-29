module Tree.Node exposing (..)
-- (view, view_notop, update, selection, selected_note_paths)

import Html as H exposing (Html)
import Model exposing (..)
import Msg   exposing  (..)
import Tree.Leaf as Leaf
import Set exposing (Set)

import Tree exposing (Tree, children)

import Tree.Filter exposing (..)


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

viewFolder : Folders -> Html Msg
viewFolder node =
  view_noTop folderVisible FolderMsg node

viewTag : Selection -> Tags -> Html Msg
viewTag selection node =
  view_noTop (tagVisible selection) TagMsg node

viewNote : Selection -> Notes -> Html Msg
viewNote selection node =
  view_noTop (noteVisible selection) NoteMsg node

view_noTop : (ItemTree a -> Bool) -> (NodeMsg -> Msg) -> ItemTree a -> Html Msg
view_noTop isVisible treeMsg node =
    uli (node |> Tree.children |> sort |> List.map (view isVisible treeMsg) )


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

branches : ( ItemTree a -> Bool ) -> (NodeMsg -> Msg) -> ItemTree a -> List (Html Msg)
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

selected_nodes : ItemTree a -> ItemList a
selected_nodes tree =
  Tree.flatten tree
  |> List.filter Leaf.isSelected

selected_notes : (Item a -> b) -> ItemTree a -> List b
selected_notes field tree =
  selected_nodes tree
  |> List.map field

folder_paths : Tree Folder -> List String
folder_paths folder =
  selected_nodes folder
  |> List.map .path

note_tags : Model -> List String
note_tags model =
  []


tag_names : Model -> Set String
tag_names model =
  selected_nodes model.tag
  |> List.map .name
  |> Set.fromList
