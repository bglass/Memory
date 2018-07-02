port module Port exposing (..)

port elm2js : String -> Cmd msg
port js2elm : (List String -> msg) -> Sub msg
