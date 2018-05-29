module Update exposing (..)

-- import Http

import Model  exposing (..)
import Msg exposing (..)
import Json.Decode as JD
import Tree

-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
      ( model, Cmd.none )
    FolderMsg fmsg ->
      ( { model | folder = Tree.update fmsg model.folder }, Cmd.none )
    TagMsg fmsg ->
      ( { model | folder = Tree.update fmsg model.tag },    Cmd.none )
    NoteMsg fmsg ->
      ( { model | folder = Tree.update fmsg model.note },   Cmd.none )

    ModelUpdate (Ok data) ->
      let
        result = JD.decodeString decoder data
      in
        case result of
          Ok decoded ->
            ( decoded, Cmd.none )
          Err error ->
            ( {model | errmsg = format_err error}, Cmd.none )
    ModelUpdate (Err error) ->
      ( {model | errmsg = format_err error}, Cmd.none )

decoder : JD.Decoder Model
decoder =
  JD.map7 Model
    ( JD.field "folder"    (JD.list Tree.decoder)    )
    ( JD.field "tag"       (JD.list Tree.decoder)    )
    ( JD.field "note"      (JD.list Tree.decoder)    )
    ( JD.field "book"      (JD.string)         )  --  (JD.list d_Article) )
    ( JD.field "search"    (JD.string)         )  --  (JD.list JD.string) )
    ( JD.field "config"    (JD.string)         )  --  (d_Config)          )
    ( JD.field "errmsg"    (JD.string)         )

format_err : a -> String
format_err error =
  "(EE) " ++ (toString error)
