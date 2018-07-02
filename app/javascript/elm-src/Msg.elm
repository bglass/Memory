module Msg exposing (..)

import Http exposing (Error)

type Msg
  = NoOp
  | ModelUpdate (Result Http.Error String)
  | BookUpdate  (Result Http.Error String)
  | RequestBook NodeMsg
  | FolderMsg NodeMsg
  | NoteMsg   NodeMsg
  | TagMsg    NodeMsg
  | EditSet  String
  | EditCall String

type NodeMsg
  = Selected  String
  | OpenClose String

type TreeType
  = FolderTree
  | TagTree
  | NoteTree
