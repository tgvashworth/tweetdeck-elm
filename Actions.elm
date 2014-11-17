module Actions where

import Model ( .. )
import Data.Login

actions : Signal Action
actions =
  merges Data.Login.actions

