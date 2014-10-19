module Step (step) where

import Debug
import Http

import Model ( AppState, Action (NoOp, Step), temporaryFakeAuthedUserState )

step : Action -> AppState -> AppState
step action appState =
  case Debug.watch "currentAction" action of
    NoOp   -> appState
    Login  ->
        { appState | working <- True }
    Step f -> f appState
