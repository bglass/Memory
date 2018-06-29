module Model exposing (..)

import Set exposing (Set)
import Tree exposing (Tree)


type alias Folders = Tree Folder
type alias Notes   = Tree Note
type alias Tags    = Tree Tag

type alias ItemTree a = Tree (Item a)
type alias ItemList a = List (Item a)
type alias Link = List String

type alias Model =
  { folder  : Tree Folder
  , tag     : Tree Tag
  , note    : Tree Note
  , link    : Relations
  , book    : Book    -- List Article
  , search  : String    -- Search
  , config  : String    -- Config
  , errmsg  : String
  }

type alias Book = List Article

type alias Article =
  { key       : String
  , date      : String
  , tags      : List String
  , resource  : String
  , html      : String
  , source    : String
  , mode      : ArticleMode
  }

type ArticleMode = ArticleView | ArticleEdit

type alias Item a =
  { a
  | name : String
  , key  : String
  , state : State
  , style : Style
  }


type alias Folder =
  { key      : String
  , name     : String
  , path     : String
  , state    : State
  , style    : Style
  }

type alias Note =
  { key      : String
  , name     : String
  , resource : String
  , state    : State
  , style    : Style
  }

type alias Tag =
  { key      : String
  , name     : String
  , path     : String
  , state    : State
  , style    : Style
  }


type alias Relations =
  { note_folder : List Link
  , note_tag    : List Link
  }

type alias State =
  { opened      : Bool
  , enabled     : Bool
  , visible     : Bool
  , selected    : Bool
  , selectable  : Bool
  , checked     : Bool
  , checkable   : Bool
}

type alias Style = String -- TBD

type alias Selection =
  { folder_paths : List String
  , note_tags    : List String
  , tag_names    : Set String
  }
