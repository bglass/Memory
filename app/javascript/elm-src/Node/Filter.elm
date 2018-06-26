module Node.Filter exposing (..)

import Model exposing (..)
import Msg   exposing  (..)

import Tree exposing (Tree)

folderVisible folder =
  nodeVisible folder

nodeVisible item =
  Tree.label item
  |> .state
  |> .visible




-- isVisible : TreeType -> Selection -> Item a -> Bool
-- isVisible tree selection node =
--   node.state.visible
--   && filterTree tree selection node

-- filterTree : TreeType -> Selection -> Item a -> Bool
-- filterTree tree selection node =
--   case tree of
--     FolderTree -> True
--     TagTree    -> True
--     NoteTree   ->
--       noteFolderSelected selection node

noteFolderSelected : Selection -> Note -> Bool
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
