module Update exposing (..)
import Msg   exposing  (Msg(..))
import Model exposing  (..)
import Json.Decode as JD
import Init

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp -> ( model, Cmd.none )

    FolderMsg sub ->
      ( model, Cmd.none )
    NoteMsg sub ->
      ( model, Cmd.none )
    TagMsg sub ->
      ( model, Cmd.none )

    ModelUpdate (Err error) ->
      ( {model | errmsg = format_err error}, Cmd.none )
    ModelUpdate (Ok download) ->
      let result = JD.decodeString decoder download
      in
        case result of
          Ok decoded ->
            ( decoded, Cmd.none )
          Err error ->
            ( {model | errmsg = format_err error}, Cmd.none )

decoder : JD.Decoder Model
decoder =
  JD.map8 Model
    ( JD.field "folder"    (folderDecoder)    )
    ( JD.field "tag"       (tagDecoder)    )
    ( JD.field "note"      (noteDecoder)    )
    ( JD.field "link"      (relationsDecoder)    )
    ( JD.succeed           ""         )  --  (JD.list d_Article) )
    ( JD.succeed           ""         )           --  (JD.list JD.string) )
    ( JD.succeed           ""         )           --  (d_Config)          )
    ( JD.field "errmsg"    (JD.string)         )

format_err : a -> String
format_err error =
  "(EE) " ++ (toString error)


-- type alias HasTree a = { a | tree : T.Model }

-- update : T.Msg -> HasTree a -> HasTree a
-- update msg data =
--   let
--     message = remap_TMsg msg
--   in
--     {data | tree = T.update message data.tree}

-- remap_TMsg : T.Msg -> T.Msg
-- remap_TMsg msg =
--   (case msg of
--     T.Toggle key ->
--       T.Toggle key
--
--     T.Select key ->    -- select->toggle
--       T.Toggle key
--
--     T.Search str ->
--       T.Search str
--
--     T.ToggleCheck m c k v->
--       T.ToggleCheck m c k v
--   )


folderDecoder : JD.Decoder Folder
folderDecoder =
  -- JD.map2 Folder
  JD.map Folder
    ( JD.field "tree"       nodeDecoder)
    -- ( JD.field "path"       (JD.dict JD.string) )

tagDecoder : JD.Decoder Tag
tagDecoder =
  JD.map Tag
    ( JD.field "tree"       nodeDecoder)
    -- ( JD.field "path"       (JD.dict JD.string) )
    -- ( JD.field "notes"      (JD.dict (JD.list JD.string) ) )

noteDecoder : JD.Decoder Note
noteDecoder =
  -- JD.map2 Note
  JD.map Note
    ( JD.field "tree"       nodeDecoder)
    -- ( JD.field "path"       (JD.dict JD.string) )

nodeDecoder : JD.Decoder Node
nodeDecoder =
  JD.map5 Node
    ( JD.field "id"        JD.string )
    ( JD.field "name"      JD.string )
    ( JD.succeed           Init.defaultState )
    ( JD.succeed           Init.defaultStyle )
    -- ( JD.field "data"      payloadDecoder )
    ( JD.field "children"
      <| JD.map Children
      <| JD.maybe
      <| JD.list
      <| JD.lazy
      <| \_ -> nodeDecoder
    )

relationsDecoder : JD.Decoder Relations
relationsDecoder =
  JD.map2 Relations
    ( JD.field "note_folder"  (JD.list linkDecoder) )
    ( JD.field "note_tag"     (JD.list linkDecoder) )

linkDecoder : JD.Decoder Link
linkDecoder =
  JD.list JD.string
