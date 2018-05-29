module Init  exposing (dummy, load)
import Model exposing (..)
import Msg exposing (Msg(..))
import Tree
import Treeview as T
import Http

load : ( Model, Cmd Msg )
load =
  (mdl, get_model)

get_model =
  Http.send ModelUpdate (Http.getString  "/model/")

dummy : ( Model, Cmd Msg )
dummy =
  (mdl, Cmd.none)

mdl : Model
-- mdl = Model f t n b s c err
mdl = Model f b s c err

err : String
err = "  ."

f : T.Node
f = T.Node "F1" "P1" Tree.defaultOptions (Just [])

    -- ( JD.field "id"        JD.string )
    -- ( JD.field "name"      JD.string )
    -- ( JD.succeed      defaultOptions )
    -- ( JD.field "children"  <|
    --   JD.maybe (
    --     JD.list (JD.lazy (\_ -> decoder )))
    -- )



-- t : Tag
-- t = tag "T1" []
--
-- n : Note
-- n = note "N1" "P1" "D1" []

b : String
b = ""
-- b = [ Article "A1" "D1"
--     , Article "A2" "D2"
--     , Article "A3" "D3"
--     ]

s : String
s = ""
-- s = Search "REF" "RET" "REN" "REB"

c : String
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
