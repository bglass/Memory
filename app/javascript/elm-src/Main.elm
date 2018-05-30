import Html exposing (Html )
import Http
import Json.Decode as JD
import Element exposing (..)
import Element.Attributes exposing (..)

import View.Style exposing (..)
import Msg exposing (Msg(..))
import Subscriptions
import Tree
import Display

-- import Flags  exposing (..)

main : Program Never Model Msg
main = Html.program
  { init          = init
  , update        = update
  , view          = view
  , subscriptions = Subscriptions.none
  }

-- MODEL

type alias Model =
  { folder  : Tree.Folder
  , tag     : Tree.Tag
  , note    : Tree.Note
  , book    : String    -- List Article
  , search  : String    -- Search
  , config  : String    -- Config
  , errmsg  : String
  }

-- INIT

init : ( Model, Cmd Msg )
init =
  (empty, request_data)

empty : Model
empty = Model
  Tree.folder_init
  Tree.tag_init
  Tree.note_init
  ""                -- book
  ""                -- search
  ""                -- config
  " ."              -- (error) message

request_data : Cmd Msg
request_data =
  Http.send ModelUpdate (Http.getString  "/model/")

-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp -> ( model, Cmd.none )

    FolderMsg sub ->
      ( { model | folder = Tree.update sub model.folder }, Cmd.none )
    NoteMsg sub ->
      ( { model | note   = Tree.update sub model.note },   Cmd.none )
    TagMsg sub ->
      ( { model | tag    = Tree.update sub model.tag },    Cmd.none )

    ModelUpdate (Err error) ->
      ( {model | errmsg = format_err error}, Cmd.none )
    ModelUpdate (Ok data) ->
      let result = JD.decodeString decoder data
      in
        case result of
          Ok decoded ->
            ( decoded, Cmd.none )
          Err error ->
            ( {model | errmsg = format_err error}, Cmd.none )

decoder : JD.Decoder Model
decoder =
  JD.map7 Model
    ( JD.field "folder"    (Tree.folderDecoder)    )
    ( JD.field "tag"       (Tree.tagDecoder)    )
    ( JD.field "note"      (Tree.noteDecoder)    )
    ( JD.field "book"      (JD.string)         )  --  (JD.list d_Article) )
    ( JD.field "search"    (JD.string)         )  --  (JD.list JD.string) )
    ( JD.field "config"    (JD.string)         )  --  (d_Config)          )
    ( JD.field "errmsg"    (JD.string)         )

format_err : a -> String
format_err error =
  "(EE) " ++ (toString error)

-- VIEW

view : Model -> Html Msg
view model =
  Element.viewport stylesheet <|
    column None
      []
      [ el None [ ] <|
        column Main
          [ ]
          (List.concat
            [ viewGridLayout model
            ]
          ),
          text model.errmsg
      ]

viewGridLayout : Model -> List (Element Styles variation Msg)
viewGridLayout model =
    [ Element.grid Container
        [ spacing 1, height (px 600) ]
        { columns = [percent 20, percent 20, percent 20, fill]
        , rows =
            [ px 20
            , px 20
            , px 20
            , fill
            , px 20
            ]
        , cells =
            [ cell_at 0 0 3 1 view_date
            , cell_at 0 1 3 1 <| Display.tag    model.tag
            , cell_at 0 2 3 1 <| Display.folder model.folder
            , cell_at 0 3 1 1 <| Tree.view      model.folder FolderMsg
            , cell_at 1 3 1 1 <| Tree.view      model.tag    TagMsg
            , cell_at 2 3 1 1 <| Tree.view      model.note   NoteMsg
            , cell_at 3 0 1 4 view_book
            , cell_at 0 4 1 1 view_re_folder
            , cell_at 1 4 1 1 view_re_tag
            , cell_at 2 4 1 1 view_re_note
            , cell_at 3 4 1 1 view_re_book
            ]
        }
    ]


cell_at : Int -> Int -> Int -> Int -> Element style variation msg -> OnGrid (Element style variation msg)
cell_at x y w h content =
  cell
    { start = ( x, y )
    , width = w
    , height = h
    , content = content
    }

dummy_box : String -> Element Styles variation msg
dummy_box atext =
  (el Box[] (text atext))

view_date : Element Styles variation msg
view_date =
  dummy_box "the date"

view_tag : Element Styles variation msg
view_tag =
  dummy_box "tags"

view_folder : Element Styles variation msg
view_folder =
  dummy_box "folder"


view_book : Element Styles variation msg
view_book =
  dummy_box "a book"

view_re_folder : Element Styles variation msg
view_re_folder =
  dummy_box "re folder"

view_re_tag : Element Styles variation msg
view_re_tag =
  dummy_box "re tag"

view_re_note : Element Styles variation msg
view_re_note =
  dummy_box "re note"

view_re_book : Element Styles variation msg
view_re_book =
  dummy_box "re book"
