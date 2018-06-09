module Model exposing (..)


type alias Model =
  { folder  : Folder
  , tag     : Tag
  , note    : Note
  , link    : Relations
  , book    : String    -- List Article
  , search  : String    -- Search
  , config  : String    -- Config
  , errmsg  : String
  }

type alias Folder =
  { tree  : Node
  }

type alias Note =
  { tree  : Node
  }

type alias Tag =
  { tree  : Node
  }

type alias Link = List String

type alias Relations =
  { note_folder : List Link
  , note_tag    : List Link
  }

type alias Node =
  { key      : String
  , name     : String
  , path     : String
  , state    : State
  , style    : Style
  , children : Children
}


-- type alias Payload = -- defined by User
--   { date      : String
--   , resource  : String
--   }

type alias State =
  { opened      : Bool
  , enabled     : Bool
  , visible     : Bool
  , selected    : Bool
  , selectable  : Bool
  , checked     : Bool
  , checkable   : Bool
}

type Children = Children (Maybe (List Node))

type alias Style = String -- TBD

type alias Selection =
  { folder_paths : List String
  , note_tags    : List String
  , tag_names    : List String
  }
