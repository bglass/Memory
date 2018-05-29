module Msg exposing (..)

import Treeview as T exposing (Msg)
import Http exposing (Error)

type Msg
  = NoOp
  | FolderMsg T.Msg
  | ModelUpdate (Result Http.Error String)
