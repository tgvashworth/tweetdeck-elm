module Inputs where

import Debug
import Model ( InputAction, InputStepper, Action ( Step, Login ), Stepper )
import Graphics.Input ( Input, input )
import Graphics.Input.Field as Field

{- How do I abstract these? -}

inputs : [Signal Action]
inputs =
  [ (loginInputs.button.action <~ loginInputs.button.input.signal) ]
  ++
  map makeStep
      [ (loginInputs.username.action <~ loginInputs.username.input.signal)
      , (loginInputs.password.action <~ loginInputs.password.input.signal)
      ]

makeStep : Signal Stepper -> Signal Action
makeStep = lift Step

type LoginInputs =
  { username : InputStepper Field.Content
  , password : InputStepper Field.Content
  , button   : InputAction ()
  }

loginInputs : LoginInputs
loginInputs =
  { username =
    { input  = input Field.noContent
    , action = loginUsernameAction
    }
  , password =
    { input  = input Field.noContent
    , action = loginPasswordAction
    }
  , button =
    { input  = input ()
    , action = (always Login)
    }
  }

-- Username

loginUsernameAction : Field.Content -> Stepper
loginUsernameAction content appState =
  let login = appState.login in
  { appState | login <- { login | username <- Debug.watch "username"  content } }

-- Password

loginPasswordAction : Field.Content -> Stepper
loginPasswordAction content appState =
  let login = appState.login in
  { appState | login <- { login | password <- Debug.watch "password" content } }
