module Editor exposing (..)

import Msg exposing (..)
import Json.Decode as JD
import Html.Events as HE
import Model exposing (..)
import Markdown
import Html exposing (..)
import Html.Attributes as HA exposing (class)
import String.Extra as SE

onKeyUp : String -> Attribute Msg
onKeyUp article_key =
  HE.on "keyup"
  ( JD.map2 Edit
    ( JD.succeed article_key)
    keypress
  )


update : Article -> KeyPress -> Article
update article pressed =
  if pressed.keyCode == 39 then                       -- Right Arrow
    { article | cursor = cursorIncrement article.cursor }
  else if pressed.keyCode == 37 then                  -- Left Arrow
    { article | cursor = cursorDecrement article.cursor }
  else if pressed.keyCode == 36 then                  -- Home
    { article | cursor = Cursor 0 0 }
  else if pressed.keyCode == 35 then                  -- End
    { article | cursor = Cursor 0 -1 }
  else if pressed.keyCode == 46 then                  -- DEL
    { article | cursor = Cursor 0 -1 }

  else if String.length pressed.key  == 1 then
    insert pressed.key article
  else
    article

cursorIncrement : Cursor -> Cursor
cursorIncrement cursor =
  { cursor | col = cursor.col + 1 }

cursorDecrement : Cursor -> Cursor
cursorDecrement cursor =
  {cursor | col = cursor.col - 1 }


keypress : JD.Decoder KeyPress
keypress = JD.map2 KeyPress
  ( JD.field "keyCode"    JD.int)
  ( JD.field "key"        JD.string)

-- VIEW

view : Article -> Html msg
view article =
  article.source
  |> insertCursor article.cursor
  |> Markdown.toHtml []
  -- |> innerHtml
  |> List.singleton
  |> div [class "article"]
  |> List.singleton
  |> div [class "article_frame"]


insertCursor : Cursor -> String -> String
insertCursor cursor source =
  SE.insertAt "|" cursor.col source

insert : String -> Article -> Article
insert symbol article =
  let
    source = SE.insertAt symbol article.cursor.col article.source
    cursor = Cursor 0 (article.cursor.col+1)
  in
    { article | source = source, cursor = cursor }
