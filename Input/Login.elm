module Input.Login where

import Signal (..)
import Graphics.Input.Field as Field
import List

import Model (..)

actions : List (Signal Action)
actions =
  List.map makeStep
      [ makeLoginUsernameAction <~ (subscribe loginFormInputs.username)
      , makeLoginPasswordAction <~ (subscribe loginFormInputs.password) ]

--- Login form

type alias LoginFormInputs =
  { username : Channel Field.Content
  , password : Channel Field.Content
  , action   : Channel ()
  }

siLoginData : Signal LoginData
siLoginData =
  let siUsername  = loginDataSignals.username
      siPassword  = loginDataSignals.password
  in (sampleOn (subscribe loginFormInputs.action) ((,) <~ siUsername ~ siPassword))

loginFormInputs : LoginFormInputs
loginFormInputs =
  { username = channel Field.noContent
  , password = channel Field.noContent
  , action   = channel ()
  }

loginDataSignals =
  { username = (.string <~ (subscribe loginFormInputs.username))
  , password = (.string <~ (subscribe loginFormInputs.password))
  }

makeLoginUsernameAction : Field.Content -> Stepper
makeLoginUsernameAction content appState =
  let login = appState.login in
  { appState | login <- { login | username <- content } }

makeLoginPasswordAction : Field.Content -> Stepper
makeLoginPasswordAction content appState =
  let login = appState.login in
  { appState | login <- { login | password <- content } }
