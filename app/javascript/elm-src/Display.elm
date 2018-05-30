module Display exposing (..)

import Element exposing (..)
import Tree
import Treeview as T
import Dict

-- VIEW

tag : Tree.Tag -> Element style variation msg
tag t =
  selected_names t.tree
  |> toString
  |> text

folder : Tree.Folder -> Element style variation msg
folder f =
  selected_keys f.tree
  |> List.map ( flip Dict.get <| f.path)
  |> List.filterMap identity
  |> toString
  |> text

selected_names :  List T.Node -> List String
selected_names nodes =
  selected_nodes nodes
  |> List.map T.nodeTitle


selected_keys : List T.Node -> List String
selected_keys nodes =
  selected_nodes nodes
  |> List.map T.nodeKey

selected_nodes : List T.Node -> List T.Node
selected_nodes nodes =
  List.map selected_subnodes nodes
  |> List.concat

selected_subnodes : T.Node -> List T.Node
selected_subnodes node =
  let
    selected_children =
      children node
      |> List.map selected_subnodes
      |> List.concat
  in
    if  node |> is_checked then
      (node) :: selected_children
    else
      selected_children

children : T.Node -> List T.Node
children node =
  case T.nodeChildren node of
    Nothing    ->   []
    Just value ->   value

is_checked : T.Node -> Bool
is_checked (T.Node _ _ opt _) =
    opt.checked
