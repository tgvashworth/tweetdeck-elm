module Inputs where

import Debug
import Model ( IA, Action ( Step ), Stepper )
import Graphics.Input ( Input, input )
import Graphics.Input.Field as Field

{- How do I abstract these? -}

inputs : [Signal Action]
inputs =
  map makeStep
    [ (loginInputs.username.action <~ loginInputs.username.input.signal)
    , (loginInputs.password.action <~ loginInputs.password.input.signal)
    ]

makeStep : Signal Stepper -> Signal Action
makeStep = lift Step

type LoginInputs =
  { username : IA Field.Content
  , password : IA Field.Content
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
