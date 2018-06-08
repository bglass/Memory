module Init exposing (..)

import Model exposing (..)
import Msg   exposing  (Msg(..))
import Http


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

-- styles : T.Styles
-- styles =
--   [ T.Style "folder" ("folder yellow", "folder-open yellow") ""
--   , T.Style "note"   ("file-o", "file-o") "green"
--   , T.Style "tag"    ("tag", "tag") "blue"
--   ]

-- cfg_default : T.Config
-- cfg_default = T.default styles
--
-- cfg_checkbox : T.Config
-- cfg_checkbox =
--   { cfg_default | checkbox =
--     { enable = True, multiple = True, cascade = True}
--   }
--
-- cfg_sort : T.Config
-- cfg_sort =
--   { cfg_checkbox | sort = T.Asc
--   }


folder_init : Folder
folder_init = Folder
                ( Node "K1" "N1" defaultState defaultStyle childless
                )

tag_init : Tag
tag_init  = Tag
                ( Node "K1" "N1" defaultState defaultStyle childless
                )

note_init : Note
note_init = Note
                ( Node "K1" "N1" defaultState defaultStyle childless
                )

childless : Children
childless = Children []

link_init : Relations
link_init = Relations [] []

-- noData : Payload
-- noData = Payload "" ""

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
