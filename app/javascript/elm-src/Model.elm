module Model exposing (..)

type alias Model =
  { folders : List Folder
  , tags    : List Tag
  , notes   : List Note
  , book    : List Article
  , search  : Search
  , config  : Config
  }

-- main elements

type alias Folder =
  { name     : String
  , resource : Path
  }

type alias Tag =
  { name     : String
  , resource : Path
  }

type alias Note =
  { name     : String
  , resource : Path
  , date     : Date
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
  { locations : List Location
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
