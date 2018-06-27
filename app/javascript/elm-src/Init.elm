module Init exposing (..)

import Model exposing (..)
import Msg   exposing  (Msg(..))
import Http

import Tree exposing (Tree, tree)


load : ( Model, Cmd Msg )
load =
  (empty, request_data)

empty : Model
empty = Model
  folder_init
  tag_init
  note_init
  link_init
  ""                -- book
  ""                -- search
  ""                -- config
  " ."              -- (error) message

request_data : Cmd Msg
request_data =
  Http.send ModelUpdate (Http.getString  "/model/")


folder_init : Tree Folder
folder_init =
  tree ( Folder "K1" "N1" "P1" defaultState defaultStyle) []

tag_init : Tree Tag
tag_init  =
  tree ( Tag "K1" "N1" "P1" defaultState defaultStyle) []

note_init : Tree Note
note_init =
  tree ( Note "K1" "N1" "R1" defaultState defaultStyle) []

link_init : Relations
link_init = Relations [] []

defaultStyle : String
defaultStyle = ""

defaultState : State
defaultState =
  { opened      = False
  , enabled     = True
  , visible     = True
  , selected    = False
  , selectable  = True
  , checked     = False
  , checkable   = True
  }
