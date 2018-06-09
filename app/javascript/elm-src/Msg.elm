module Msg exposing (..)

import Treeview as T exposing (Msg)
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

type Tree
  = FolderTree
  | TagTree
  | NoteTree

treeMsg : Tree -> NodeMsg -> Msg
treeMsg tree =
  case tree of
    FolderTree -> FolderMsg
    TagTree    -> TagMsg
    NoteTree   -> NoteMsg
