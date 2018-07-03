module Book exposing (view, setEdit, edit)

import Html exposing (..)
import Html.Attributes as HA exposing (class)
import Html.Events as HE
import Msg exposing (..)
-- import Json.Encode as JE
-- import Json.Decode as JD
import Model exposing (..)
import Set exposing (Set)
import Editor

-- UPDATE

setEdit : Book -> String -> Book
setEdit  book article_key =
  List.map (setArticleEdit article_key) book

setArticleEdit : String -> Article -> Article
setArticleEdit key article =
  -- if article.key == key then
  --   { article | mode = ArticleEdit }
  -- else
    article


edit : Book -> String -> KeyPress -> Book
edit book article_key keyval =
  book
  |> List.map (editArticle article_key keyval)

editArticle : String -> KeyPress -> Article -> Article
editArticle  article_key keyval article =
  if article.key == article_key then
    Editor.update article keyval 
  else
    article

-- VIEW

view : Selection -> Book -> Html Msg
view selection book =
    book
    |> List.map (viewArticle selection)
    |> div [class "book"]

viewArticle : Selection -> Article -> Html Msg
viewArticle selection article =
  div [ class "article_wrap"
      -- , eventEdit article.key
      , HA.id ("v" ++ article.key)
      , Editor.onKeyUp article.key
      , HA.tabindex 0
      ]
  [ viewDate    article.date
  , viewTags    selection article.tags
  , Editor.view article
  ]

viewDate : String -> Html msg
viewDate date = date
  |> text
  |> List.singleton
  |> div [class "article_date"]

viewTags : Selection -> List String -> Html msg
viewTags selection tags =
  selection.tag_names
  |> Set.diff (Set.fromList <| tags)
  |> Set.toList
  |> List.map text
  |> List.map List.singleton
  |> List.map (div [class "tag"])
  |> div [class "article_tags"]


-- innerHtml : String -> Html msg
-- innerHtml html = span [ JE.string html |> HA.property "innerHTML" ] []

eventEdit : String -> Attribute Msg
eventEdit key =
  HE.onDoubleClick (EditSet key)


-- eventLoaded : String -> Attribute Msg
-- eventLoaded key =
--   HE.on "load" (JD.succeed (EditCall key))
