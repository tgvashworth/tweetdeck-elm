module Step (step) where

import Model ( AppState, Action (NoOp, Step) )
import Debug

step : Action -> AppState -> AppState
step action state =
  case Debug.watch "currentAction" action of
    NoOp -> state
    Step a -> a state
