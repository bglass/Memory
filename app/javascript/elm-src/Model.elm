module Model exposing (..)

type alias Model =
  { folder  : Folder
  , tag     : Tag
  , note    : Note
  , book    : String    -- List Article
  , search  : String    -- Search
  , config  : String    -- Config
  , errmsg  : String
  }

-- main elements


type Folder = Folder
  { name     : String
  , key      : String
  , options  : Options
  , children : List Folder
  }

type Tag = Tag
  { name     : String
  -- , resource : String
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

-- Treeview package

type alias Options =
  { style: StyleName
  , selectable: Selectable
  , opened: Opened
  , disabled: Disabled
  , visible: Visible
  , checked : Checked
  }

defaultOptions = Options "None" True True False True False

type alias StyleName = String
type alias Opened = Bool
type alias Visible = Bool
type alias Checked = Bool
type alias Disabled = Bool
type alias Selectable = Bool



folder : String -> String -> List Folder -> Folder
folder name key children =
  Folder
    { name      = name
    , key       = key
    , options   = defaultOptions
    , children  = children
    }


tag : String -> List Tag -> Tag
tag name children =
  Tag
    { name      = name
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
