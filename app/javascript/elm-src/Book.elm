module Book exposing (view)

import Html exposing (..)
import Html.Attributes as HA exposing (class)
import Json.Encode as JE
import Model exposing (..)

view : Book -> Html msg
view book = book
  |> List.map viewArticle
  |> div [class "book"]


viewArticle : Article -> Html msg
viewArticle article =
  div [class "article_wrap"]
  [ viewDate    article.date
  , viewTags    article.tags
  , viewContent article.html
  ]

viewDate : String -> Html msg
viewDate date = date
  |> text
  |> List.singleton
  |> div [class "article_date"]

viewTags : List String -> Html msg
viewTags tags = tags
  |> List.map text
  |> List.map List.singleton
  |> List.map (div [class "tag"])
  |> div [class "article_tags"]

viewContent : String -> Html msg
viewContent content = content
  |> innerHtml
  |> List.singleton
  |> div [class "article"]
  |> List.singleton
  |> div [class "article_frame"]

innerHtml : String -> Html msg
innerHtml html = span [ JE.string html |> HA.property "innerHTML" ] []
