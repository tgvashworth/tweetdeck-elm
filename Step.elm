module Step (step) where

import Debug
import Http

import Model ( AppState, Action ( .. ) )

step : Action -> AppState -> AppState
step action appState =
  case Debug.log "currentAction" action of
    NoOp      -> appState
    Working b -> { appState | working <- b }
    Step f    -> f appState
