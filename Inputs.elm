module Inputs where

import Model ( .. )
import Input.Login

inputs : Signal Action
inputs =
  merges Input.Login.inputs

