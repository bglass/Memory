module Update exposing (..)
import Msg   exposing  (..)
import Model exposing  (..)
import Json.Decode as JD
import Json.Encode as JE
import Init
import Tree.Node as Node
import Http
import Book
import Port
-- import Char

import Tree exposing (Tree, tree)
import Task

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp -> ( model, Cmd.none )

    FolderMsg nodemsg ->
      ( {model | folder = Node.update nodemsg model.folder}, Cmd.none )
    NoteMsg nodemsg ->
      ( {model | note = Node.update nodemsg model.note}, message (RequestBook nodemsg) )
    TagMsg nodemsg ->
      ( {model | tag = Node.update nodemsg model.tag}, Cmd.none )

    EditSet article_key ->
      ( { model | book = Book.setEdit model.book article_key}, message (EditCall article_key) )

    EditCall article_key ->
      ( model, Port.elm2js (encodeListString["EDITOR", article_key]) )

    Edit article_key keypress ->
      ( { model | book = Book.edit model.book article_key keypress}, Cmd.none )

    RequestBook nodemsg ->
      (model, requestBook model.note nodemsg)
       -- ( model, Cmd.none )

    BookUpdate (Err error) ->
      ( {model | errmsg = format_err error}, Cmd.none )
    BookUpdate (Ok download) ->
      let result = JD.decodeString bookDecoder download
      in
        case result of
          Ok decoded ->
            ( {model | book = decoded}, Cmd.none )
          Err error ->
            ( {model | errmsg = format_err error}, Cmd.none )

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



-- http://faq.elm-community.org/#how-do-i-generate-a-new-message-as-a-command
message : msg -> Cmd msg
message msg = Task.perform identity (Task.succeed msg)

requestBook : Notes -> NodeMsg -> Cmd Msg
requestBook notes nodemsg =
  case nodemsg of
    OpenClose key -> Cmd.none
    Selected  key ->
      let
        paths = Node.selected_notes .resource notes
                |> encodeListString

      in
        Http.send BookUpdate (Http.getString ("/book?jsonpaths=" ++ paths) )


encodeListString : List String -> String
encodeListString strings =
  List.map JE.string strings
  |>       JE.list
  |> JE.encode 0

  -- |> toString




decoder : JD.Decoder Model
decoder =
  JD.map8 Model
    ( JD.field "folder"    (folderDecoder)    )
    ( JD.field "tag"       (tagDecoder)    )
    ( JD.field "note"      (noteDecoder)    )
    ( JD.field "link"      (relationsDecoder)    )
    ( JD.succeed           []         )  --  (JD.list d_Article) )
    ( JD.succeed           ""         )           --  (JD.list JD.string) )
    ( JD.succeed           ""         )           --  (d_Config)          )
    ( JD.field "errmsg"    (JD.string)         )

format_err : a -> String
format_err error =
  "(EE) " ++ (toString error)


bookDecoder : JD.Decoder Book
bookDecoder =
  JD.list articleDecoder

articleDecoder : JD.Decoder Article
articleDecoder =
  JD.map6 Article
  ( JD.field "id"        JD.string )
  ( JD.field "date"      JD.string )
  ( JD.field "tags"    ( JD.list JD.string ) )
  ( JD.field "html"      JD.string )
  ( JD.field "source"    bufferDecoder )
  ( JD.succeed           ArticleView )

bufferDecoder : JD.Decoder Buffer
bufferDecoder =
  JD.map2 Buffer
    ( JD.succeed "")
    ( JD.string )

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
      ( JD.field "resource"  JD.string )
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
