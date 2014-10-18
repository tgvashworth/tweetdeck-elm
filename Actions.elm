module Actions (actions) where

import Model ( Action ( NoOp ) )
import Inputs
import Graphics.Input ( Input, input )

actions : Signal Action
actions = merges Inputs.inputs
