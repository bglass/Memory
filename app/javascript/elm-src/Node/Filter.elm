module Node.Filter exposing (..)

import Model exposing (..)
import Msg   exposing  (..)

isVisible : TreeType -> Selection -> Node -> Bool
isVisible tree selection node =
  node.state.visible
  && filterTree tree selection node

filterTree : TreeType -> Selection -> Node -> Bool
filterTree tree selection node =
  case tree of
    FolderTree -> True
    TagTree    -> True
    NoteTree   ->
      noteFolderSelected selection node

noteFolderSelected : Selection -> Node -> Bool
noteFolderSelected selection note =
  if List.isEmpty selection.folder_paths then
    True
  else
    List.member note.path selection.folder_paths
