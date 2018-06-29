module Tree.Filter exposing (..)

import Model exposing (..)

import Tree exposing (Tree)

-- Visibility

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


-- Selection

noteFolderSelected : Selection -> Note -> Bool
noteFolderSelected selection note =
  if List.isEmpty selection.folder_paths then
    True
  else
    selection.folder_paths
    |> List.filter ((flip String.startsWith) note.resource)
    |> List.isEmpty
    |> not

-- Sorting

sort : List (ItemTree a) -> List (ItemTree a)
sort nodes =
  List.sortBy lowName nodes

lowName : ItemTree a -> String
lowName node =
  node
  |> Tree.label
  |> .name
  |> String.toLower
