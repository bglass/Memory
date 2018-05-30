module Tree exposing (..)

import Html exposing (Html)
import Element exposing (Element)
import Json.Decode as JD
import Dict

import Treeview as T
-- import View.Tree.Style as VTS

import Msg exposing (..)

-- MODEL

type alias Node  = T.Node

type alias Folder =
  { tree  : T.Model
  , path  : Dict.Dict String String
  , notes : Dict.Dict String (List String)
  }

type alias Note =
  { tree  : T.Model
  }

type alias Tag =
  { tree  : T.Model
  }

-- INIT

styles : T.Styles
styles =
  [ T.Style "folder" ("folder yellow", "folder-open yellow") ""
  , T.Style "note"   ("file-word-o", "file-word-o") "blue"
  , T.Style "tag"    ("file-archive-o", "file-archive-o") ""
  ]

config : T.Config
config = T.default styles

folder_init : Folder
folder_init = Folder
                [T.Node "F1" "P1" folderDefaults (Just [])]
                Dict.empty Dict.empty

tag_init : Tag
tag_init  = Tag
              [T.Node "T1" "S1" tagDefaults (Just [])]

note_init : Note
note_init = Note
              [T.Node "N1" "M1" noteDefaults (Just [])]

folderDefaults : T.Options
folderDefaults =
  { style       = "folder"
  , selectable  = True
  , opened      = False
  , disabled    = False
  , visible     = True
  , checked     = False
  }

tagDefaults : T.Options
tagDefaults  = {folderDefaults | style = "tag"}

noteDefaults : T.Options
noteDefaults = {folderDefaults | style = "note"}



-- UPDATE

folder_update : T.Msg -> Folder -> Folder
folder_update msg folder =
  {folder | tree = update msg folder.tree}

tag_update : T.Msg -> Tag -> Tag
tag_update msg tag =
  {tag | tree = update msg tag.tree}

note_update : T.Msg -> Note -> Note
note_update msg note =
  {note | tree = update msg note.tree}

update : T.Msg -> T.Model -> T.Model
update msg model =
  T.update msg model
  -- [T.Node "F1" "P1" defaultOptions (Just [])]

folderDecoder : JD.Decoder Folder
folderDecoder =
  JD.map3 Folder
    ( JD.field "tree"       (JD.list (decoder folderDefaults) ) )
    ( JD.field "path"       (JD.dict JD.string) )
    ( JD.field "notes"      (JD.dict (JD.list JD.string) ) )

tagDecoder : JD.Decoder Tag
tagDecoder =
  JD.map Tag
    ( JD.field "tree"       (JD.list (decoder tagDefaults) ) )
    -- ( JD.field "path"       (JD.dict JD.string) )
    -- ( JD.field "notes"      (JD.dict (JD.list JD.string) ) )

noteDecoder : JD.Decoder Note
noteDecoder =
  JD.map Note
    ( JD.field "tree"       (JD.list (decoder noteDefaults ) ) )
    -- ( JD.field "path"       (JD.dict JD.string) )
    -- ( JD.field "notes"      (JD.dict (JD.list JD.string) ) )

decoder : T.Options -> JD.Decoder T.Node
decoder options =
  JD.map4 T.Node
    ( JD.field "id"        JD.string )
    ( JD.field "name"      JD.string )
    ( JD.succeed           options   )
    ( JD.field "children"  <|
      JD.maybe (
        JD.list (JD.lazy (\_ -> (decoder options ))))
    )

-- VIEW


view_folder : Folder -> Element style variation Msg
view_folder folder =
  view folder.tree FolderMsg

view_note : Note -> Element style variation Msg
view_note note =
  view note.tree NoteMsg

view_tag : Tag -> Element style variation Msg
view_tag tag =
  view tag.tree TagMsg

view : T.Model -> (T.Msg -> msg) -> Element style variation msg
view top parentmsg =
  Element.html
  ( Html.div []
    [ Html.map parentmsg (T.view config top)
    ]
  )
