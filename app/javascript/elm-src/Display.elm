module Display exposing (..)

import Html as H exposing (Html)
import Html.Attributes as HA
import Set

import Tree exposing (Tree)

-- import Dict
-- import Node
import Model exposing (..)

import Msg exposing (..)

-- VIEW

tag : Selection -> Html Msg
tag selection =
  selection.tag_names
  |> Set.toList
  |> List.map H.text
  |> List.map List.singleton
  |> List.map (H.div [HA.class "tag"])
  |> H.span [HA.class "state_tag_set"]

folder : Selection -> Tree Folder -> Html Msg
folder selection f =
  selection.folder_paths
  |> toString
  |> H.text
