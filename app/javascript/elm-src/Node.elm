module Node exposing (view, view_notop, update, children, selection)

import Html as H exposing (Html)
import Html.Attributes as HA
import Html.Events as HE
import Model exposing (..)
import View.Style exposing (..)
import Msg   exposing  (..)
import Node.State exposing (..)
import Class
import Dict

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



children_each : (Node -> Node) -> Node -> Children
children_each func node =
  Children (Just (node |> children |> List.map func ) )


-- VIEW

view_notop : TreeType -> Selection -> Node -> Html Msg
view_notop tree selection node =
    uli (node |> children |> List.map (view tree selection) )

view : TreeType -> Selection -> Node -> Html Msg
view tree selection node =
  if isVisible tree selection node then
    if node.state.opened then
      uli
        ( [item tree node]
            ++ (node |> children |> List.map (view tree selection) )
        )
    else
      uli [item tree node]
  else
    H.text ""

isVisible : TreeType -> Selection -> Node -> Bool
isVisible tree selection node =
  node.state.visible
  && filterTree tree selection node

filterTree : TreeType -> Selection -> Node -> Bool
filterTree tree selection node =
  case tree of
    FolderTree -> True
    TagTree    -> True
    NoteTree   ->
      noteFolderSelected selection node

noteFolderSelected : Selection -> Node -> Bool
noteFolderSelected selection note =
  -- List.member note.path selection.folder_paths
  True

children : Node -> (List Node)
children node =
  case node.children of
    Children  Nothing        -> []
    Children (Just children) -> children


eventSelect : TreeType -> Node -> H.Attribute Msg
eventSelect tree node =
  HE.onClick ((treeMsg tree) (Selected node.key))

eventOpenClose : TreeType -> Node -> H.Attribute Msg
eventOpenClose tree node =
  HE.onClick ((treeMsg tree) (OpenClose node.key))


style : Node -> H.Attribute msg
style node =
  HA.style []

text : Node -> Html msg
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


item : TreeType -> Node -> Html Msg
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

icon : Node -> List (H.Attribute msg)
icon node =
  if List.isEmpty (node |> children) then
    Class.nodeChildless
  else if node.state.opened then
    Class.nodeOpened
  else
    Class.nodeClosed

selected_nodes : Node -> List Node
selected_nodes node =
  let
    selected_children =
      children node
      |> List.map selected_nodes
      |> List.concat
  in
    if  node.state.selected then
      (node) :: selected_children
    else
      selected_children

selection : Model -> Selection
selection model = { folder_paths = folder_paths model
                  , note_tags    = note_tags    model
                  , tag_names    = tag_names    model
                  }

tag_names model =
  selected_nodes model.tag.tree
  |> List.map .name

folder_paths model =
  selected_nodes model.folder.tree
  |> List.map .key
  |> List.map ( flip Dict.get <| model.folder.path)
  |> List.filterMap identity

note_tags model =
  []
