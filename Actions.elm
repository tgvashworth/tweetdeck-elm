module Actions where

import Model ( .. )
import Input.Login

actions : Signal Action
actions =
  merges Input.Login.inputs

