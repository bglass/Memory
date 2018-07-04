module Editor exposing (..)

import Msg exposing (..)
import Json.Decode as JD
import Html.Events as HE
import Model exposing (..)
import Markdown
import Html exposing (..)
import Html.Attributes as HA exposing (class)
import Regex exposing (..)
import Dict exposing (Dict)

onKeyDown : String -> Attribute Msg
onKeyDown article_key =
  HE.on "keydown"
  ( JD.map2 Edit
    ( JD.succeed article_key)
    keypress
  )


update : Article -> KeyPress -> Article
update article pressed =
    { article | source = modify pressed article.source.left article.source.right }


modify : KeyPress -> String -> String -> Buffer
modify pressed old_left old_right =

  if pressed.keyCode == 39 then                 -- Right Arrow
    Buffer  ( old_left ++ (String.left 1 old_right) )
            ( String.dropLeft 1 old_right )

  else if pressed.keyCode == 37 then                   -- Left Arrow
    Buffer  ( String.dropRight 1 old_left )
            ( (String.right 1 old_left) ++ old_right )

  else if pressed.keyCode == 36 then                   -- Home
    Buffer  ""
            (old_left ++ old_right )

  else if pressed.keyCode == 35 then                   -- End
    Buffer  ( old_left ++ old_right )
            ""

  else if pressed.keyCode == 46 then                   -- BS
    Buffer  old_left
            (String.dropLeft 1 old_right )

  else if pressed.keyCode == 8 then                   -- DEL
    Buffer  ( String.dropRight 1 old_left )
            old_right

  else if pressed.keyCode == 13 then                   -- Enter
    Buffer  ( old_left ++ "\n" )
            old_right

  else if String.length pressed.key  == 1 then        -- printable symbol
    Buffer  ( old_left ++ pressed.key )
            old_right

  else                                                 -- no idea -> do nothing
    Buffer old_left old_right

keypress : JD.Decoder KeyPress
keypress = JD.map2 KeyPress
  ( JD.field "keyCode"    JD.int)
  ( JD.field "key"        JD.string)

-- VIEW

view : Article -> Html msg
view article =
  expose article.source
  |> bufferToList
  |> String.join cursor
  |> Markdown.toHtml []
  |> List.singleton
  |> div [class "article"]
  |> List.singleton
  |> div [class "article_frame"]

bufferToList : Buffer -> List String
bufferToList buffer = [buffer.left, buffer.right]

expose : Buffer -> Buffer
expose source =
  source
  |> exposeWhitespace


exposeWhitespace : Buffer -> Buffer
exposeWhitespace buffer =
  let
    leftContent  = replace All (regex "[\\s\\*\\-]*$") (\_ -> "") buffer.left
    rightContent = replace All (regex "^[\\s\\*\\-]*") (\_ -> "") buffer.right

    leftSpace    = String.right ((String.length buffer.left) - (String.length leftContent)) buffer.left
    rightSpace   = String.left ((String.length buffer.right) - (String.length rightContent)) buffer.right

    leftExpose   = exchange leftSpace
    rightExpose  = exchange rightSpace

    rawSpace     = leftSpace ++ rightSpace
  in
    if (contains (regex "\\n[\\*\\-] ") rawSpace) then
      if (leftSpace == "") || (rightSpace == "") then
        Buffer buffer.left buffer.right
      else
        Buffer (leftContent ++ leftExpose) (rightExpose ++ rawSpace ++ rightContent)

    else if rawSpace == " " then
      Buffer buffer.left buffer.right

    else if rawSpace == "\n" then
      Buffer (leftContent++leftExpose) (rightExpose++rightContent)

    else if (String.length rightSpace) == 0 then
      Buffer (leftContent ++ leftExpose++rawSpace) rightContent

    else
      Buffer (leftContent ++ leftExpose) (rightExpose ++ rawSpace ++ rightContent)

exchange : String -> String
exchange string = string
  |> String.toList
  |> List.map ((flip Dict.get) exposeLUT)
  |> List.map (Maybe.withDefault '?')
  |> String.fromList
  |> expose_tag

expose_tag : String -> String
expose_tag exposed =
  "<b class='exposed'>" ++ exposed ++ "</b>"

exposeLUT : Dict Char Char
exposeLUT = Dict.fromList [(' ', '⎵'), ('\n', linefeed), ('*', '*'), ('-', '-')]

cursor : String
cursor = "<b id='CUR'></b>"

linefeed : Char
linefeed = '␊'


replace1 : String -> (Match -> String) -> String -> String
replace1 regstring =
  replace (AtMost 1) (regex regstring)
