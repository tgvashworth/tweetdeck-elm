module Input.Login where

import Graphics.Input ( Input, input )
import Graphics.Input.Field as Field

import Model ( .. )

actions : [Signal Action]
actions =
  map makeStep
      [ makeLoginUsernameAction <~ loginFormInputs.username.signal
      , makeLoginPasswordAction <~ loginFormInputs.password.signal ]

--- Login form

type LoginFormInputs =
  { username : Input Field.Content
  , password : Input Field.Content
  , action   : Input ()
  }

siLoginData : Signal LoginData
siLoginData =
  let siUsername  = loginDataSignals.username
      siPassword  = loginDataSignals.password
  in (sampleOn loginFormInputs.action.signal ((,) <~ siUsername ~ siPassword))

loginFormInputs : LoginFormInputs
loginFormInputs =
  { username = input Field.noContent
  , password = input Field.noContent
  , action   = input ()
  }

loginDataSignals =
  { username = (.string <~ loginFormInputs.username.signal)
  , password = (.string <~ loginFormInputs.password.signal)
  }

makeLoginUsernameAction : Field.Content -> Stepper
makeLoginUsernameAction content appState =
  let login = appState.login in
  { appState | login <- { login | username <- content } }

makeLoginPasswordAction : Field.Content -> Stepper
makeLoginPasswordAction content appState =
  let login = appState.login in
  { appState | login <- { login | password <- content } }
