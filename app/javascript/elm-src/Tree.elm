module Tree exposing (..)

import Html exposing (Html)
import Element exposing (Element)
import Json.Decode as JD
import Dict

import Treeview as T
-- import View.Tree.Style as VTS

-- import Msg exposing (..)

-- MODEL

type alias Node  = T.Node

type alias Folder =
  { tree  : T.Model
  , path  : Dict.Dict String String
  }

type alias Note =
  { tree  : T.Model
  , path  : Dict.Dict String String
  }

type alias Tag =
  { tree  : T.Model
  }

type alias Link = List String

type alias Relations =
  { note_folder : List Link
  , note_tag    : List Link
  }

-- INIT

styles : T.Styles
styles =
  [ T.Style "folder" ("folder yellow", "folder-open yellow") ""
  , T.Style "note"   ("file-o", "file-o") "green"
  , T.Style "tag"    ("tag", "tag") "blue"
  ]

cfg_default : T.Config
cfg_default = T.default styles

cfg_checkbox : T.Config
cfg_checkbox =
  { cfg_default | checkbox =
    { enable = True, multiple = True, cascade = True}
  }

cfg_sort : T.Config
cfg_sort =
  { cfg_checkbox | sort = T.Asc
  }


folder_init : Folder
folder_init = Folder
                [T.Node "F1" "P1" folderDefaults (Just [])]
                Dict.empty

tag_init : Tag
tag_init  = Tag
              [T.Node "T1" "S1" tagDefaults (Just [])]

note_init : Note
note_init = Note
              [T.Node "N1" "M1" noteDefaults (Just [])]
              Dict.empty

link_init = Relations [] []


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

type alias HasTree a = { a | tree : T.Model }

update : T.Msg -> HasTree a -> HasTree a
update msg data =
  let
    message = remap_TMsg msg
  in
    {data | tree = T.update message data.tree}

remap_TMsg : T.Msg -> T.Msg
remap_TMsg msg =
  (case msg of
    T.Toggle key ->
      T.Toggle key

    T.Select key ->    -- select->toggle
      T.Toggle key

    T.Search str ->
      T.Search str

    T.ToggleCheck m c k v->
      T.ToggleCheck m c k v
  )


folderDecoder : JD.Decoder Folder
folderDecoder =
  JD.map2 Folder
    ( JD.field "tree"       (JD.list (decoder folderDefaults) ) )
    ( JD.field "path"       (JD.dict JD.string) )

tagDecoder : JD.Decoder Tag
tagDecoder =
  JD.map Tag
    ( JD.field "tree"       (JD.list (decoder tagDefaults) ) )
    -- ( JD.field "path"       (JD.dict JD.string) )
    -- ( JD.field "notes"      (JD.dict (JD.list JD.string) ) )

noteDecoder : JD.Decoder Note
noteDecoder =
  JD.map2 Note
    ( JD.field "tree"       (JD.list (decoder noteDefaults ) ) )
    ( JD.field "path"       (JD.dict JD.string) )

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

relationsDecoder : JD.Decoder Relations
relationsDecoder =
  JD.map2 Relations
    ( JD.field "note_folder"  (JD.list linkDecoder) )
    ( JD.field "note_tag"     (JD.list linkDecoder) )

linkDecoder : JD.Decoder Link
linkDecoder =
  JD.list JD.string





-- VIEW

view : HasTree a -> (T.Msg -> msg) -> Element style variation msg
view data parentmsg =
  Element.html
  ( Html.div []
    [ Html.map parentmsg (T.view cfg_checkbox data.tree)
    ]
  )
