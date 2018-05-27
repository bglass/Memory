module Data.Decode exposing (..)

import Json.Decode as JD
import Model exposing (Children, Folder)


-- folders : String -> Result String (List Folder)
folders data =
  -- JD.decodeString folderList data
  []


--
-- folderList : JD.Decoder (List Folder)
-- folderList =
--   JD.list folder
--
-- folder : JD.Decoder Folder
-- folder =
--   JD.map3 Folder
--     (JD.field "text"                JD.string)
--     (JD.field "id"                  JD.string)
--     (JD.maybe JD.field "children"   children)
--
-- children : JD.Decoder Children
-- children =
--   JD.map (JD.maybe (List Folder) ( JD.lazy ( \_ -> folderList ) ) )
--




--
-- decodePlanNode =
--     decode PlanNode
--         |> required "Node Type" Decode.string
--         |> optional "Plans" (Decode.lazy (\_ -> decodePlans)) (Plans [])
--
--
-- decodePlans =
--     Decode.map Plans <| Decode.list (Decode.lazy (\_ -> decodePlanNode))
