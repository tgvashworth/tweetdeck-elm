module Actions where

import Model (..)
import Data.Login
import Signal

actions : Signal Action
actions =
  Signal.mergeMany Data.Login.actions

