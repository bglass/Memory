module Class exposing (..)

import Html.Attributes as HA
import Html as H

li : H.Attribute msg
li = HA.class "fa-li"

ul : List (H.Attribute msg)
ul = [HA.class "group fa-ul"]

nodeChildless : List (H.Attribute msg)
nodeChildless = [HA.class "node icon childless"]

nodeOpened : List (H.Attribute msg)
nodeOpened = [HA.class "node icon opened"]

nodeClosed : List (H.Attribute msg)
nodeClosed = [HA.class "node icon closed"]
