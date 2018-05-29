module Msg exposing (..)

import Treeview as T exposing (Msg)
import Http exposing (Error)

type Msg
  = NoOp
  | TagMsg T.Msg
  | NoteMsg T.Msg
  | FolderMsg T.Msg
  | ModelUpdate (Result Http.Error String)
