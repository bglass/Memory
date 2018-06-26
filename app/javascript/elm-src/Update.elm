module Update exposing (..)
import Msg   exposing  (..)
import Model exposing  (..)
import Json.Decode as JD
import Json.Encode as JE
import Init
-- import Node
-- import Http

import Tree exposing (Tree, tree)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp -> ( model, Cmd.none )

    FolderMsg nodemsg ->
      -- ( {model | folder = update_tree nodemsg model.folder}, Cmd.none )
      ( model, Cmd.none )
    NoteMsg nodemsg ->
      -- ( {model | note = update_tree nodemsg model.note}, requestBook model.note nodemsg)
      ( model, Cmd.none )
    TagMsg nodemsg ->
      -- ( {model | tag = update_tree nodemsg model.tag}, Cmd.none )
      ( model, Cmd.none )

    BookUpdate x ->
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

-- requestBook : Note -> NodeMsg -> Cmd Msg
-- requestBook note nodemsg =
--   case nodemsg of
--     Selected key ->
--       let
--         notes = Node.selected_note_paths note.tree
--                 |> encodeListString
--
--       in
--         Http.send BookUpdate (Http.getString ("/book?jsonpaths=" ++ notes) )
--     OpenClose key ->
--       Cmd.none


encodeListString : List String -> String
encodeListString strings =
  List.map JE.string strings
  |>       JE.list
  |> JE.encode 0

  -- |> toString

-- update_tree : Msg.NodeMsg -> { a | tree : Node } -> { a | tree : Node }
-- update_tree nodemsg model =
--   { model | tree = Node.update nodemsg model.tree }
--   model


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



folderDecoder : JD.Decoder (Tree Folder)
folderDecoder =
  JD.map2 tree
    ( JD.map5 Folder
      ( JD.field "id"        JD.string )
      ( JD.field "name"      JD.string )
      ( JD.field "path"      JD.string )
      ( JD.succeed           Init.defaultState )
      ( JD.succeed           Init.defaultStyle )
    )
    ( JD.field "children"
      <| JD.list
      <| JD.lazy
      <| (\_ -> folderDecoder)
    )


tagDecoder : JD.Decoder (Tree Tag)
tagDecoder =
  JD.map2 tree
    ( JD.map5 Tag
      ( JD.field "id"        JD.string )
      ( JD.field "name"      JD.string )
      ( JD.field "path"      JD.string )
      ( JD.succeed           Init.defaultState )
      ( JD.succeed           Init.defaultStyle )
    )
    ( JD.field "children" <| JD.list <| JD.lazy <| (\_ -> tagDecoder) )

noteDecoder : JD.Decoder (Tree Note)
noteDecoder =
  JD.map2 tree
    ( JD.map5 Note
      ( JD.field "id"        JD.string )
      ( JD.field "name"      JD.string )
      ( JD.field "path"      JD.string )
      ( JD.succeed           Init.defaultState )
      ( JD.succeed           Init.defaultStyle )
    )
    ( JD.field "children" <| JD.list <| JD.lazy <| (\_ -> noteDecoder) )


relationsDecoder : JD.Decoder Relations
relationsDecoder =
  JD.map2 Relations
    ( JD.field "note_folder"  (JD.list linkDecoder) )
    ( JD.field "note_tag"     (JD.list linkDecoder) )

linkDecoder : JD.Decoder Link
linkDecoder =
  JD.list JD.string
