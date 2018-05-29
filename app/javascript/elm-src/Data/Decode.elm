module Data.Decode exposing (..)

import Json.Decode as JD
import Model exposing (..)



model : String -> Result String Model
model data =
  decode d_Model data

decode : JD.Decoder a -> String -> Result String a
decode decoder data =
  JD.decodeString decoder data

d_Model : JD.Decoder Model
d_Model =
  JD.map7 Model
    ( JD.field "folder"    (d_Folder)  )
    ( JD.field "tag"       (d_Tag)     )
    ( JD.field "note"      (d_Note)    )
    ( JD.field "book"      (JD.string)         )  --  (JD.list d_Article) )
    ( JD.field "search"    (JD.string)         )  --  (JD.list JD.string) )
    ( JD.field "config"    (JD.string)         )  --  (d_Config)          )
    ( JD.field "errmsg"    (JD.string)         )



d_Folder : JD.Decoder Folder
d_Folder =
  JD.map3 folder
    ( JD.field "name"      JD.string )
    ( JD.field "id"        JD.string )
    ( JD.field "children"  <|
        JD.list (JD.lazy (\_ -> d_Folder ))
    )


d_Tag : JD.Decoder Tag
d_Tag =
  JD.map2 tag
    ( JD.field "name"      JD.string )
    ( JD.field "children"  <|
        JD.list (JD.lazy (\_ -> d_Tag ))
    )


d_Note : JD.Decoder Note
d_Note =
  JD.map4 note
    ( JD.field "name"           JD.string )
    ( JD.field "resource_name"  JD.string )
    ( JD.field "date"           JD.string )
    ( JD.field "children"  <|
        JD.list (JD.lazy (\_ -> d_Note ))
    )
