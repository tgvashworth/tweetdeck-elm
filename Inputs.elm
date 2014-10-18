module Inputs where

import Model ( Action ( Step ), Stepper )
import Graphics.Input ( Input, input )
import Graphics.Input.Field as Field

{- How do I abstract these? -}

inputs : [Signal Action]
inputs =
    map makeStep
        [ (loginUsernameAction <~ loginUsernameInput.signal)
        , (loginPasswordAction <~ loginPasswordInput.signal)
        ]

makeStep : Signal Stepper -> Signal Action
makeStep = lift Step

-- Username

loginUsernameInput : Input Field.Content
loginUsernameInput = input Field.noContent

loginUsernameAction : Field.Content -> Stepper
loginUsernameAction content appState =
    let login = appState.login in
    { appState | login <- { login | username <- content } }

-- Password

loginPassword : Signal Action
loginPassword = Step <~ (loginPasswordAction <~ loginPasswordInput.signal)

loginPasswordInput : Input Field.Content
loginPasswordInput = input Field.noContent

loginPasswordAction : Field.Content -> Stepper
loginPasswordAction content appState =
    let login = appState.login in
    { appState | login <- { login | password <- content } }
