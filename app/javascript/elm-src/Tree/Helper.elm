module Tree.Helper exposing (..)

import Model exposing (..)
import Msg   exposing  (..)

import Tree exposing (Tree, children)


selected_nodes : ItemTree a -> List (ItemTree a)
selected_nodes node =
  let
    selected_children =
      children node
      |> List.map selected_nodes
      |> List.concat
  in
    if  ( Tree.label node
          |> .state
          |> .selected
        ) then
      (node) :: selected_children
    else
      selected_children

tag_names : Model -> List String
tag_names model =
  selected_nodes model.tag
  |> List.map Tree.label
  |> List.map .name

folder_paths : Tree Folder -> List String
folder_paths folder =
  selected_nodes folder
  |> List.map Tree.label
  |> List.map .path

note_tags : Model -> List String
note_tags model =
  []
