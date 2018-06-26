module Tree.Leaf exposing (..)

import Model exposing (..)
import Html.Attributes as HA
import Html as H
import Html.Events as HE
import Tree.State as State
import Msg   exposing  (..)




-- UPDATE

toggle_selection : String -> Item a -> Item a
toggle_selection key item =
  if key == item.key then
    {item | state = State.toggle_selection item.state }
  else
    item

toggle_openClose : String -> Item a -> Item a
toggle_openClose key item =
  if key == item.key then
    {item | state = State.toggle_openClose item.state }
  else
    item

isSelected : Item a -> Bool
isSelected item =
  item |> .state |> .selected


  -- selected_nodes tree
  -- |> List.map .resource
  -- ["zwo", "drei", "vier"]

-- VIEW


-- viewItem : (NodeMsg -> Msg) -> ItemTree a -> Html Msg
view treeMsg icon item =
  H.span []
  [   H.span
      [ li
      , eventOpenClose treeMsg item
      ]
      [
        H.span icon []
      ]
  , H.div
      [
      style item
      , eventSelect treeMsg item
      , class item
      ]
      [text item]
  ]

text : Item a -> H.Html msg
text item =
  item
  |> .name
  |> H.text

eventSelect : (NodeMsg -> Msg) -> Item a -> H.Attribute Msg
eventSelect treeMsg item =
  HE.onClick (treeMsg (Selected item.key))

eventOpenClose : (NodeMsg -> Msg) -> Item a -> H.Attribute Msg
eventOpenClose treeMsg item =
  HE.onClick (treeMsg (OpenClose item.key))

-- Style

li : H.Attribute msg
li = HA.class "fa-li"

ul : List (H.Attribute msg)
ul = [HA.class "group fa-ul"]


style : a -> H.Attribute msg
style node =
  HA.style []

class : Item a -> H.Attribute msg
class item =
  HA.classList
  [ ("node", True)
  , ("selected", item.state.selected)
  , ("checked",  item.state.checked)
  , ("opened",   item.state.opened)
  , ("closed",   not item.state.opened)
  , ("disabled", not item.state.enabled)
  , ("hidden",   not item.state.visible)
  ]

nodeChildless : List (H.Attribute msg)
nodeChildless = [HA.class "node icon childless"]

nodeOpened : List (H.Attribute msg)
nodeOpened = [HA.class "node icon opened"]

nodeClosed : List (H.Attribute msg)
nodeClosed = [HA.class "node icon closed"]
