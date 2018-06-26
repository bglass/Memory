module Tree.State exposing (..)

import Model exposing (..)

toggle_selection : State -> State
toggle_selection state =
  {state | selected = not state.selected}

toggle_openClose : State -> State
toggle_openClose state =
  {state | opened = not state.opened}
