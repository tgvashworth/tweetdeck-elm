module Actions (actions) where

import Model ( Action )
import Inputs

actions : Signal Action
actions = merges Inputs.inputs
