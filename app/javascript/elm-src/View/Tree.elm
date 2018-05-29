module View.Tree exposing (..)

import View.Tree.Folder as F
import Model exposing (Folder,Tag,Note)
import Element exposing (Element)
import Update exposing (Msg)

folders : Folder -> Element style variation Msg
folders records =
  F.view records
