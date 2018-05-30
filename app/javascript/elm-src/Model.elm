module Model exposing (..)

import Tree

type alias Model =
  { folder  : Tree.Folder
  , tag     : List Tree.Node
  , note    : List Tree.Node
  , book    : String    -- List Article
  , search  : String    -- Search
  , config  : String    -- Config
  , errmsg  : String
  }

-- main elements

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
