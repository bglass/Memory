module Display exposing (..)

import Element as E exposing (Element)
import Dict
import Node
import Model exposing (..)

-- VIEW

tag : Tag -> Element style variation msg
tag t =
  selected_names t.tree
  |> toString
  |> E.text

folder : Folder -> Element style variation msg
folder f =
  selected_keys f.tree
  |> List.map ( flip Dict.get <| f.path)
  |> List.filterMap identity
  |> toString
  |> E.text

selected_names :  Node -> List String
selected_names node =
  selected_nodes node
  |> List.map .name

selected_keys : Node -> List String
selected_keys node =
  selected_nodes node
  |> List.map .key

selected_nodes : Node -> List Node
selected_nodes node =
  let
    selected_children =
      Node.children node
      |> List.map selected_nodes
      |> List.concat
  in
    if  node.state.selected then
      (node) :: selected_children
    else
      selected_children
