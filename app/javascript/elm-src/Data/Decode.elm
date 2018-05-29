module Data.Decode exposing (..)

import Json.Decode as JD
import Model exposing (..)



--
--
-- d_Tag : JD.Decoder Tag
-- d_Tag =
--   JD.map2 tag
--     ( JD.field "name"      JD.string )
--     ( JD.field "children"  <|
--         JD.list (JD.lazy (\_ -> d_Tag ))
--     )
--
--
-- d_Note : JD.Decoder Note
-- d_Note =
--   JD.map4 note
--     ( JD.field "name"           JD.string )
--     ( JD.field "resource_name"  JD.string )
--     ( JD.field "date"           JD.string )
--     ( JD.field "children"  <|
--         JD.list (JD.lazy (\_ -> d_Note ))
--     )
