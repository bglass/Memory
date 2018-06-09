module Display exposing (..)

import Html as H exposing (Html)
import Html.Attributes as HA
-- import Html.Events as HE

import Dict
import Node
import Model exposing (..)

import Msg exposing (..)

-- import View.Style exposing (Styles(..))
-- import Style

-- VIEW

tag : Tag -> Html Msg
tag t =
  selected_names t.tree
  |> List.map H.text
  |> List.map List.singleton
  |> List.map (H.div [HA.class "tag"])
  |> H.span [HA.class "state_tag_set"]

folder : Folder -> Html Msg
folder f =
  selected_keys f.tree
  |> List.map ( flip Dict.get <| f.path)
  |> List.filterMap identity
  |> toString
  |> H.text

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
