module Node.Filter exposing (..)

import Model exposing (..)
import Msg   exposing  (..)

import Tree exposing (Tree)

folderVisible : Tree Folder -> Bool
folderVisible node =
  nodeVisible node

noteVisible :Selection -> Tree Note -> Bool
noteVisible selection node =
  nodeVisible node
  && noteFolderSelected selection (Tree.label node)

tagVisible : Selection -> Tree Tag -> Bool
tagVisible selection node =
  nodeVisible node

nodeVisible : Tree (Item a) -> Bool
nodeVisible node =
  Tree.label node
  |> .state
  |> .visible



-- noteFolderSelected : Selection -> Note -> Bool
noteFolderSelected selection note =
  if List.isEmpty selection.folder_paths then
    True
  else
    selection.folder_paths
    |> List.filter ((flip String.startsWith) note.path)
    |> List.isEmpty
    |> not

sort nodes =
  List.sortBy lowName nodes

lowName node =
  node
  |> Tree.label
  |> .name
  |> String.toLower
