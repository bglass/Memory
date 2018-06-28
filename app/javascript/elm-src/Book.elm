module Book exposing (view)

import Html exposing (..)
import Html.Attributes as HA
import Json.Encode as JE
import Model exposing (..)

view : Book -> Html msg
view book =
  book
  |> List.map .html
  |> List.map textHtml
  |> div []


textHtml : String -> Html msg
textHtml html = span [ JE.string html |> HA.property "innerHTML" ] []
