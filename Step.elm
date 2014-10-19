module Step (step) where

import Model ( AppState, Action (NoOp, Step), temporaryFakeAuthedUserState )
import Debug

step : Action -> AppState -> AppState
step action appState =
  case Debug.watch "currentAction" action of
    NoOp   -> appState
    Login  -> { appState | user <- Just temporaryFakeAuthedUserState }
    Step f -> f appState
