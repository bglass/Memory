module Msg exposing (Msg(..))

import Treeview as T exposing (Msg)
import Http exposing (Error)

type Msg
  = NoOp
  | ModelUpdate (Result Http.Error String)
  | FolderMsg T.Msg
  | NoteMsg   T.Msg
  | TagMsg    T.Msg
