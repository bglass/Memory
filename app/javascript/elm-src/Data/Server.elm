module Data.Server exposing (..)
import Http

import Update exposing (..)
import Model exposing (..)

get : String -> Cmd Msg
get url =
  Http.send FolderUpdate (Http.getString url)




-- folderListDecoder : JD.Decoder (List Folder)
-- folderListDecoder =
--   JD.list folderDecoder
--
-- folderDecoder : JD.Decoder Folder
-- folderDecoder =
--   JD.map3 Folder
--     (JD.field "text"     JD.string)
--     (JD.field "id"       JD.string)
--     (JD.field "children" (JD.map (List Folder) (JD.list (JD.lazy (\_ -> folderListDecoder)))))
--
--
--


--
--
--
--
--
--
-- request_folder url =
--   Http.get url folderListDecoder
--
--
--
-- get_folder data =
--   JD.at ["id", "text"] JD.string
--
--
-- decodeList =
--   JD.list JD.string
--
--
-- decodeData : JD.Decoder String
-- decodeData =
--   JD.at ["id", "text"] JD.string


-- decodeString (list int) "[1,2,3]"       == Ok [1,2,3]
-- decodeString (at ["person", "name"] string) json  == Ok "tom"
