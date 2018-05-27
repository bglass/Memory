import Html exposing (text)
import Json.Decode as JD

type alias Folder =
  { name     : String
  , key      : String
  , children : Children
  }

type Children = Maybe (List Folder)
-- type Children = Empty | (List Folder)

data = "[{\"text\":\"Gollum\",\"id\":\"69\",\"children\":[{\"text\":\"hallo\",\"id\":\"117\",\"children\":[],\"data\":{\"path\":\"Gollum/hallo\"}}],\"data\":{\"path\":\"Gollum\"}},{\"text\":\"Nexus\",\"id\":\"70\",\"children\":[{\"text\":\"Bookmarks\",\"id\":\"71\",\"children\":[],\"data\":{\"path\":\"Nexus/Bookmarks\"}},{\"text\":\"Howto\",\"id\":\"72\",\"children\":[],\"data\":{\"path\":\"Nexus/Howto\"}},{\"text\":\"Tools\",\"id\":\"73\",\"children\":[],\"data\":{\"path\":\"Nexus/Tools\"}},{\"text\":\"Install\",\"id\":\"74\",\"children\":[],\"data\":{\"path\":\"Nexus/Install\"}},{\"text\":\"Try\",\"id\":\"75\",\"children\":[],\"data\":{\"path\":\"Nexus/Try\"}},{\"text\":\"LBW\",\"id\":\"76\",\"children\":[],\"data\":{\"path\":\"Nexus/LBW\"}},{\"text\":\"ASH\",\"id\":\"77\",\"children\":[],\"data\":{\"path\":\"Nexus/ASH\"}},{\"text\":\"Development\",\"id\":\"78\",\"children\":[],\"data\":{\"path\":\"Nexus/Development\"}},{\"text\":\"Shopping\",\"id\":\"79\",\"children\":[],\"data\":{\"path\":\"Nexus/Shopping\"}}],\"data\":{\"path\":\"Nexus\"}},{\"text\":\"Mobile\",\"id\":\"80\",\"children\":[{\"text\":\"trash\",\"id\":\"81\",\"children\":[],\"data\":{\"path\":\"Mobile/trash\"}},{\"text\":\"Howto\",\"id\":\"82\",\"children\":[{\"text\":\"A Subfolder\",\"id\":\"83\",\"children\":[{\"text\":\"A subsub\",\"id\":\"84\",\"children\":[],\"data\":{\"path\":\"Mobile/Howto/A Subfolder/A subsub\"}},{\"text\":\"Another Subsub\",\"id\":\"85\",\"children\":[],\"data\":{\"path\":\"Mobile/Howto/A Subfolder/Another Subsub\"}}],\"data\":{\"path\":\"Mobile/Howto/A Subfolder\"}}],\"data\":{\"path\":\"Mobile/Howto\"}},{\"text\":\"Try Out\",\"id\":\"86\",\"children\":[{\"text\":\"ok\",\"id\":\"87\",\"children\":[],\"data\":{\"path\":\"Mobile/Try Out/ok\"}}],\"data\":{\"path\":\"Mobile/Try Out\"}}],\"data\":{\"path\":\"Mobile\"}}]"

folders : String -> Result String (List Folder)
folders data =
  JD.decodeString folderListDecoder data

folderListDecoder : JD.Decoder (List Folder)
folderListDecoder =
  JD.list folderDecoder

folderDecoder : JD.Decoder Folder
folderDecoder =
  JD.map3 Folder
    (JD.field "text"                JD.string)
    (JD.field "id"                  JD.string)
    (JD.maybe JD.field "children"   childrenDecoder)

childrenDecoder : JD.Decoder Children
childrenDecoder =
  JD.map (JD.maybe Children ( JD.lazy ( \_ -> folderListDecoder ) ) )

main =
  text (toString folders)
