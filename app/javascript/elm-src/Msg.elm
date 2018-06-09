module Msg exposing (..)

import Http exposing (Error)

type Msg
  = NoOp
  | ModelUpdate (Result Http.Error String)
  | FolderMsg NodeMsg
  | NoteMsg   NodeMsg
  | TagMsg    NodeMsg

type NodeMsg
  = Selected  String
  | OpenClose String

type TreeType
  = FolderTree
  | TagTree
  | NoteTree

treeMsg : TreeType -> NodeMsg -> Msg
treeMsg tree =
  case tree of
    FolderTree -> FolderMsg
    TagTree    -> TagMsg
    NoteTree   -> NoteMsg
