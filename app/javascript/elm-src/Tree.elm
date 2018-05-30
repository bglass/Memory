module Tree exposing (..)

import Html exposing (Html)
import Element exposing (Element)
import Json.Decode as JD
import Dict

import Treeview as T
-- import View.Tree.Style as VTS

import Msg exposing (..)

-- MODEL

-- type alias Model = T.Model
type alias Node  = T.Node

type alias Folder =
  { tree  : T.Model
  , path  : Dict.Dict String String
  , notes : Dict.Dict String (List String)
}

-- INIT

folder_init : Folder
folder_init = Folder
                [T.Node "F1" "P1" defaultOptions (Just [])]
                Dict.empty Dict.empty


defaultOptions : T.Options
defaultOptions = -- T.Options -- "None" True True False True False
  { style       = "folder"
  , selectable  = True
  , opened      = False
  , disabled    = False
  , visible     = True
  , checked     = False
  }

-- UPDATE

folder_update : T.Msg -> Folder -> Folder
folder_update msg folder =
  {folder | tree = update msg folder.tree}

update : T.Msg -> T.Model -> T.Model
update msg model =
  T.update msg model
  -- [T.Node "F1" "P1" defaultOptions (Just [])]

folderDecoder : JD.Decoder Folder
folderDecoder =
  JD.map3 Folder
    ( JD.field "tree"       (JD.list decoder ) )
    ( JD.field "path"       (JD.dict JD.string) )
    ( JD.field "notes"      (JD.dict (JD.list JD.string) ) )

decoder : JD.Decoder T.Node
decoder =
  JD.map4 T.Node
    ( JD.field "id"        JD.string )
    ( JD.field "name"      JD.string )
    ( JD.succeed      defaultOptions )
    ( JD.field "children"  <|
      JD.maybe (
        JD.list (JD.lazy (\_ -> decoder )))
    )

-- VIEW


view_folder : Folder -> Element style variation Msg
view_folder folder =
  view folder.tree FolderMsg

view : T.Model -> (T.Msg -> msg) -> Element style variation msg
view top parentmsg =
  Element.html
  ( Html.div []
    [ Html.map parentmsg (T.view config top)
    ]
  )

styles : T.Styles
styles =
  [ T.Style "folder" ("folder yellow", "folder-open yellow") ""
  , T.Style "archive" ("file-archive-o", "file-archive-o") ""
  , T.Style "word" ("file-word-o", "file-word-o") "blue"
  , T.Style "image" ("file-image-o", "file-image-o") ""
  , T.Style "pdf" ("file-pdf-o", "file-pdf-o") "red"
  , T.Style "powerpoint" ("file-powerpoint-o", "file-powerpoint-o") "orange"
  , T.Style "excel" ("file-excel-o", "file-excel-o") "green"
  ]

config : T.Config
config = T.default styles
