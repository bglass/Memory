module Model exposing (..)

type alias Model =
  { folders : List Folder
  , tags    : List Tag
  , notes   : List Note
  , book    : String    -- List Article
  , search  : String    -- Search
  , config  : String    -- Config
  , errmsg  : String
  }

-- main elements


type Folder = Folder
  { name     : String
  , key      : String
  , children : List Folder
  }

type Tag = Tag
  { name     : String
  , resource : String
  , children : List Tag
  }

type Note = Note
  { name     : String
  , resource : String
  , date     : String
  , children : List Note
  }

type alias Article =
  { content  : Markdown
  , date     : Date
  }

type alias Search =
  { re_folder   : Regex
  , re_tag      : Regex
  , re_note     : Regex
  , re_book     : Regex
  }

type alias Config =
  {
    locations : List Location
  }

type alias Location =
  { name    : String
  , backend : String
  , fs_path : Path
  }

-- basic elements

type alias Path     = String
type alias Date     = String
type alias Markdown = String
type alias Regex    = String

-- constructors

folder : String -> String -> List Folder -> Folder
folder name key children =
  Folder
    { name      = name
    , key       = key
    , children  = children
    }


tag : String -> String -> List Tag -> Tag
tag name resource children =
  Tag
    { name      = name
    , resource  = resource
    , children  = children
    }

note : String -> String -> String -> List Note -> Note
note name resource date children =
  Note
    { name      = name
    , resource  = resource
    , date      = date
    , children  = children
    }
