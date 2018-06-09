module Node exposing (view, update, children)

import Html as H exposing (Html)
import Html.Attributes as HA
import Html.Events as HE
import Model exposing (..)
import View.Style exposing (..)
import Msg   exposing  (..)
import Node.State exposing (..)
import Class

-- UPDATE

update : NodeMsg -> Node -> Node
update nodemsg trunk =
  case nodemsg of
    Selected  key -> select    key trunk
    OpenClose key -> openClose key trunk

select : String -> Node -> Node
select key node =
  if node.key == key then
    { node | state = toggle_selection node.state }
  else
    { node | children = children_each (select key) node }

openClose : String -> Node -> Node
openClose key node =
  if node.key == key then
    { node | state = toggle_openClose node.state }
  else
    { node | children = children_each (openClose key) node }



children_each func node =
  Children (Just (node |> children |> List.map func ) )


-- VIEW

view : Tree -> Node -> Html Msg
view tree node =
  if node.state.opened then
    uli
      ( [item tree node]
          ++ (node |> children |> List.map (view tree) )
      )
  else
    uli [item tree node]


children : Node -> (List Node)
children node =
  case node.children of
    Children  Nothing        -> []
    Children (Just children) -> children


eventSelect : Tree -> Node -> H.Attribute Msg
eventSelect tree node =
  HE.onClick ((treeMsg tree) (Selected node.key))

eventOpenClose : Tree -> Node -> H.Attribute Msg
eventOpenClose tree node =
  HE.onClick ((treeMsg tree) (OpenClose node.key))


style : Node -> H.Attribute msg
style node =
  HA.style
    [ ("font-weight", "bold")
    , ("color", "blue")
    ]

text : { a | name : String } -> Html msg
text node = H.text node.name

class : Node -> H.Attribute msg
class node =
  HA.classList
  [ ("node", True)
  , ("selected", node.state.selected)
  , ("checked",  node.state.checked)
  , ("opened",   node.state.opened)
  , ("closed",   not node.state.opened)
  , ("disabled", not node.state.enabled)
  , ("hidden",   not node.state.visible)
  ]

uli : List (Html msg) -> Html msg
uli items =
  H.ul Class.ul
    [ H.li [] items
    ]


item : Tree -> Node -> Html Msg
item tree node =
  H.span []
  [   H.span
      [ Class.li
      , eventOpenClose tree node
      ]
      [ H.span (icon node) []
      ]
  , H.div
      [ style node
      , eventSelect tree node
      , class node
      ]
      [text node]
  ]

icon node =
  if List.isEmpty (node |> children) then
    Class.nodeChildless
  else if node.state.opened then
    Class.nodeOpened
  else
    Class.nodeClosed
