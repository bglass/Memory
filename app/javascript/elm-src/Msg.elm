module Msg exposing (..)

import Http exposing (Error)
import Model exposing (KeyPress)

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
  | Edit String KeyPress


type NodeMsg
  = Selected  String
  | OpenClose String

type TreeType
  = FolderTree
  | TagTree
  | NoteTree
