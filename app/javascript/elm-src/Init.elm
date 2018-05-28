module Init  exposing (dummy, load)
import Model exposing (..)
import Data.Server
import Update exposing (Msg)

load : ( Model, Cmd Msg )
load =
  (mdl, Data.Server.get_model)

dummy : ( Model, Cmd Msg )
dummy =
  (mdl, Cmd.none)

mdl : Model
mdl = Model f t n b s c err

err = "  ."

f : List Folder
f = [ folder "F1" "P1" []
    , folder "F2" "P2" []
    , folder "F3" "P3" []
    ]

t : List Tag
t = [ tag "T1" "P1" []
    , tag "T2" "P2" []
    , tag "T3" "P3" []
    ]

n : List Note
n = [ note "N1" "P1" "D1" []
    , note "N2" "P2" "D2" []
    , note "N3" "P3" "D3" []
    ]

b = ""
-- b = [ Article "A1" "D1"
--     , Article "A2" "D2"
--     , Article "A3" "D3"
--     ]

s = ""
-- s = Search "REF" "RET" "REN" "REB"

c = ""
-- c = Config
--     [ Location "N1" "B1" "P1"
--     , Location "N2" "B2" "P2"
--     , Location "N3" "B3" "P3"
--     ]


type alias Config =
  { locations : List Location
  }

type alias Location =
  { name    : String
  , backend : String
  , fs_path : Path
  }
