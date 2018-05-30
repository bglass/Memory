module Display exposing (..)

import Element exposing (..)
import Tree
import Treeview as T
import Dict

-- VIEW

folder : Tree.Folder -> Element style variation msg
folder f =
  text
    ( toString
      ( List.filterMap identity
        ( List.map
          ( flip Dict.get <| f.path) (selected_keys f.tree)
        )
      )
    )



selected_keys : List T.Node -> List String
selected_keys nodes =
  List.concat
    ( List.map selected_subnodes nodes
    )


selected_subnodes : T.Node -> List String
selected_subnodes node =
  let
    selected_children =
      List.concat
        ( List.map selected_subnodes (children node)
        )
  in
    if  node |> is_checked then
      (T.nodeKey node) :: selected_children
    else
      selected_children

children : T.Node -> List T.Node
children node =
  case T.nodeChildren node of
    Nothing    ->   []
    Just value ->   value

is_checked : T.Node -> Bool
is_checked (T.Node _ _ opt _) =
    opt.checked
