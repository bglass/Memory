module Node.Helper exposing (..)

import Model exposing (..)
import Msg   exposing  (..)


children_each : (Node -> Node) -> Node -> Children
children_each func node =
  Children (Just (node |> children |> List.map func ) )


children : Node -> (List Node)
children node =
  case node.children of
    Children  Nothing        -> []
    Children (Just children) -> children

selected_nodes : Node -> List Node
selected_nodes node =
  let
    selected_children =
      children node
      |> List.map selected_nodes
      |> List.concat
  in
    if  node.state.selected then
      (node) :: selected_children
    else
      selected_children

tag_names : Model -> List String
tag_names model =
  selected_nodes model.tag.tree
  |> List.map .name

folder_paths : Model -> List String
folder_paths model =
  selected_nodes model.folder.tree
  |> List.map .path

note_tags : Model -> List String
note_tags model =
  []
