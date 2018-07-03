module Book exposing (view, setEdit)

import Html exposing (..)
import Html.Attributes as HA exposing (class)
import Html.Events as HE
import Msg exposing (..)
import Json.Encode as JE
import Json.Decode as JD
import Model exposing (..)
import Set exposing (Set)

-- UPDATE

setEdit : Book -> String -> Book
setEdit  book article_key =
  List.map (setArticleEdit article_key) book

setArticleEdit : String -> Article -> Article
setArticleEdit key article =
  if article.key == key then
    { article | mode = ArticleEdit }
  else
    article


-- VIEW

view : Selection -> Book -> Html Msg
view selection book =
    book
    |> List.map (renderArticle selection)
    |> div [class "book"]


renderArticle : Selection -> Article -> Html Msg
renderArticle selection article =
  -- case article.mode of
  --   ArticleView -> viewArticle selection article
  --   ArticleEdit -> editArticle selection article
  div []
  [ viewArticle selection article
  , editArticle selection article
  ]


editArticle : Selection -> Article -> Html Msg
editArticle selection article =
  article.source
  |> text
  |> List.singleton
  |> textarea [ HA.hidden True
              , HA.id ("e" ++ article.key)
              ]
  |> List.singleton
  |> div  [ class "editor"]


viewArticle : Selection -> Article -> Html Msg
viewArticle selection article =
  div [ class "article_wrap"
      , eventEdit article.key
      , HA.id ("v" ++ article.key)
      ]
  [ viewDate    article.date
  , viewTags    selection article.tags
  , viewContent article.html
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

viewContent : String -> Html msg
viewContent content = content
  |> innerHtml
  |> List.singleton
  |> div [class "article"]
  |> List.singleton
  |> div [class "article_frame"]

innerHtml : String -> Html msg
innerHtml html = span [ JE.string html |> HA.property "innerHTML" ] []

eventEdit : String -> Attribute Msg
eventEdit key =
  HE.onDoubleClick (EditSet key)


-- eventLoaded : String -> Attribute Msg
-- eventLoaded key =
--   HE.on "load" (JD.succeed (EditCall key))
