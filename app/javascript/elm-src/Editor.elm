module Editor exposing (..)

import Msg exposing (..)
import Json.Decode as JD
import Html.Events as HE
import Model exposing (..)
import Markdown
import Html exposing (..)
import Html.Attributes as HA exposing (class)
import String.Extra as SE
import Regex exposing (..)


onKeyDown : String -> Attribute Msg
onKeyDown article_key =
  HE.on "keydown"
  ( JD.map2 Edit
    ( JD.succeed article_key)
    keypress
  )


update : Article -> KeyPress -> Article
update article pressed =
  let
    split_source = String.split cursor article.source
    old_left   = Maybe.withDefault "" (List.head split_source)
    old_right  = Maybe.withDefault "" (List.head (List.reverse split_source))
  in
    { article | source = String.join cursor (modify pressed old_left old_right) }


modify : KeyPress -> String -> String -> List String
modify pressed old_left old_right =
  if pressed.keyCode == 39 then                       -- Right Arrow
    [ old_left ++ (String.left 1 old_right)
    ,  String.dropLeft 1 old_right
    ]
  else if pressed.keyCode == 37 then                  -- Left Arrow
    [ String.dropRight 1 old_left
    , (String.right 1 old_left) ++ old_right
    ]
  else if pressed.keyCode == 36 then                  -- Home
    [ ""
    , old_left ++ old_right
    ]
  else if pressed.keyCode == 35 then                  -- End
    [ old_left ++ old_right
    , ""
    ]
  else if pressed.keyCode == 46 then                  -- BS
    [ old_left
    , String.dropLeft 1 old_right
    ]
  else if pressed.keyCode == 8 then                  -- DEL
    [ String.dropRight 1 old_left
    , old_right
    ]
  else if pressed.keyCode == 13 then                  -- Enter
    [ old_left ++ "\n"
    , old_right
    ]

  else if String.length pressed.key  == 1 then
    [ old_left ++ pressed.key
    , old_right
    ]
  else
    [ old_left
    , old_right
    ]

cursor : String
cursor = "[C]"

keypress : JD.Decoder KeyPress
keypress = JD.map2 KeyPress
  ( JD.field "keyCode"    JD.int)
  ( JD.field "key"        JD.string)

-- VIEW

view : Article -> Html msg
view article =
  article.source
  |> replace1 "\\[C\\]" (\_ -> "")
  |> Markdown.toHtml []
  |> List.singleton
  |> div [class "article"]
  |> List.singleton
  |> div [class "article_frame"]

replace1 : String -> (Match -> String) -> String -> String
replace1 regstring =
  replace (AtMost 1) (regex regstring)
