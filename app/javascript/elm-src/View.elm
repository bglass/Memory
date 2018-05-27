module View exposing (main_grid)
-- packages:
import Element exposing (..)
import Element.Attributes exposing (..)
-- src:
import View.Style exposing (..)

import View.Tree as Tree

main_grid model =
    Element.viewport stylesheet <|
        column None
            []
            [ el None [ ] <|
                column Main
                    [ ]
                    (List.concat
                        [ viewGridLayout model
                        ]
                    )
            ]

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
            , cell_at 0 1 3 1 view_tag
            , cell_at 0 2 3 1 view_folder
            , cell_at 0 3 1 1 <| Tree.view model.folders
            , cell_at 1 3 1 1 <| Tree.view model.tags
            , cell_at 2 3 1 1 <| Tree.view model.notes
            , cell_at 3 0 1 4 view_book
            , cell_at 0 4 1 1 view_re_folder
            , cell_at 1 4 1 1 view_re_tag
            , cell_at 2 4 1 1 view_re_note
            , cell_at 3 4 1 1 view_re_book
            ]
        }
    ]

cell_at x y w h content =
  cell
    { start = ( x, y )
    , width = w
    , height = h
    , content = content
    }

dummy_box atext =
  (el Box[] (text atext))

view_date =
  dummy_box "the date"

view_tag =
  dummy_box "tags"

view_folder =
  dummy_box "folder"


view_book =
  dummy_box "a book"
view_re_folder =
  dummy_box "re folder"

view_re_tag =
  dummy_box "re tag"

view_re_note =
  dummy_box "re note"

view_re_book =
  dummy_box "re book"
