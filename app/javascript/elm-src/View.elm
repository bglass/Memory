module View exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)

import Model exposing  (..)

import Display
import Msg   exposing  (Msg(..), TreeType(..))

import Node

view : Model -> Html Msg
view model =

  let
    selection = Node.selection model
  in
    div [class "main_grid"]
    [ div [class "state_folder_set"]    [ Display.folder  selection  model.folder]
    , div [class "state_tag_set"]       [ Display.tag     selection  ]
    , div [class "state_date_set"]      [ view_date ]
    , div [class "folder_menu"]         [  ]
    , div [class "tag_menu"]            [  ]
    , div [class "note_menu"]           [  ]
    , div [class "folder_box"]
      [
        div [class "folders"]           [ Node.viewFolder model.folder]
      ]
    , div [class "tag_box"]
      [
      div [class "tags"]              [ Node.viewTag   selection model.tag]
      ]
    , div [class "note_box"]
      [
      div [class "notes"]             [ Node.viewNote   selection model.note]
      ]
    , div [class "book"]                [ view_book ]
    , div [class "folder_search"]       [ view_re_folder ]
    , div [class "tag_search"]          [ view_re_tag ]
    , div [class "note_search"]         [ view_re_note ]
    , div [class "book_search"]         [ text model.errmsg ]
    ]

view_date      = text "the date"
view_book      = text "a book"
view_re_folder = text "re folder"
view_re_tag    = text "re tag"
view_re_note   = text "re note"
