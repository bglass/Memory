module View exposing (..)

import Element exposing (..)
import Element.Attributes exposing (..)
import Html as H exposing (Html)

import View.Style exposing (..)

import Msg   exposing  (Msg(..))
import Model exposing  (..)

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
            -- , cell_at 0 1 3 1 <| Display.tag    model.tag
            -- , cell_at 0 2 3 1 <| Display.folder model.folder
            , cell_at 0 3 1 1 <| viewTree  model.folder.tree
            , cell_at 1 3 1 1 <| viewTree  model.tag.tree
            , cell_at 2 3 1 1 <| viewTree  model.note.tree
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

viewTree : Node -> Element Styles variation Msg
viewTree node =
  Element.html (viewNode node)

viewNode : Node -> Html Msg
viewNode node =
  H.ul []
  [ H.li []
    ( [H.text node.name] ++ (node |> children |> List.map viewNode )
    )
  ]

children : Node -> (List Node)
children node =
  case node.children of
    Children  Nothing        -> []
    Children (Just children) -> children
