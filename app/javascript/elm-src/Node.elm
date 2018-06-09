module Node exposing (viewTree)

import Element as E exposing (Element)
-- import Element.Attributes exposing (..)
import Html as H exposing (Html)
import Html.Attributes as HA
import Model exposing (..)
import View.Style exposing (..)
import Msg   exposing  (Msg(..))

viewTree : Node -> Element Styles variation Msg
viewTree node =
  E.html (viewNode node)

viewNode : Node -> Html Msg
viewNode node =
  uli
    ( [item node]
        ++ (node |> children |> List.map viewNode )
    )

uli : List (Html msg) -> Html msg
uli items = H.ul [][ H.li [] items ]


children : Node -> (List Node)
children node =
  case node.children of
    Children  Nothing        -> []
    Children (Just children) -> children

item : Node -> Html msg
item node =
  H.div [style node] [text node]


style : Node -> H.Attribute msg
style node =
  HA.style
    [ ("font-weight", "bold")
    , ("color", "blue")
    ]

text : { a | name : String } -> Html msg
text node =
  H.text node.name
