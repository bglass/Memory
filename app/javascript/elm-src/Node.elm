module Node exposing (..)
import Element exposing (..)
import Element.Attributes exposing (..)
import Html as H exposing (Html)
import Model exposing (..)
import View.Style exposing (..)
import Msg   exposing  (Msg(..))

viewTree : Node -> Element Styles variation Msg
viewTree node =
  Element.html (viewNode node)

viewNode : Node -> Html Msg
viewNode node =
  uli
    ( [H.text node.name]
        ++ (node |> children |> List.map viewNode )
    )

uli : List (Html msg) -> Html msg
uli items = H.ul [][ H.li [] items ]


children : Node -> (List Node)
children node =
  case node.children of
    Children  Nothing        -> []
    Children (Just children) -> children
