module Input.Login where

import Graphics.Input ( Input, input )
import Graphics.Input.Field as Field

import Model ( .. )
import Api.Login

inputs : [Signal Action]
inputs =
    [ Api.Login.doLogin loginData ]
    ++
    map makeStep
        [ loginUsernameAction <~ loginFormInputs.username.signal
        , loginPasswordAction <~ loginFormInputs.password.signal
        ]

--- Login form

type LoginFormInputs =
  { username : Input Field.Content
  , password : Input Field.Content
  , action   : Input ()
  }

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

loginData : Signal LoginData
loginData =
  let siUsername  = loginDataSignals.username
      siPassword  = loginDataSignals.password
  in (sampleOn loginFormInputs.action.signal ((,) <~ siUsername ~ siPassword))

loginUsernameAction : Field.Content -> Stepper
loginUsernameAction content appState =
  let login = appState.login in
  { appState | login <- { login | username <- content } }

loginPasswordAction : Field.Content -> Stepper
loginPasswordAction content appState =
  let login = appState.login in
  { appState | login <- { login | password <- content } }
