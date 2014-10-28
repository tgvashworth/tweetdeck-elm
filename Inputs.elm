module Inputs where

import Debug
import Http
import Graphics.Input ( Input, input )
import Graphics.Input.Field as Field

import Encode ( base64Encode )

import Model ( .. )

{- How do I abstract these? -}

inputs : [Signal Action]
inputs =
  [ wireLogin loginData ]
  ++
  map makeStep
      [ loginUsernameAction <~ loginInputs.username.signal
      , loginPasswordAction <~ loginInputs.password.signal
      ]

makeStep : Signal Stepper -> Signal Action
makeStep = lift Step

pair : a -> b -> (a, b)
pair a b = (a, b)

--- LOGIN

type LoginInputs =
  { username : Input Field.Content
  , password : Input Field.Content
  , action   : Input ()
  }

loginInputs : LoginInputs
loginInputs =
  { username = input Field.noContent
  , password = input Field.noContent
  , action   = input ()
  }

loginDataSignals =
  { username = (.string <~ loginInputs.username.signal)
  , password = (.string <~ loginInputs.password.signal)
  }

loginData : Signal LoginData
loginData =
  let siUsername  = loginDataSignals.username
      siPassword  = loginDataSignals.password
      siLoginData = (sampleOn loginInputs.action.signal (pair <~ siUsername ~ siPassword))
  in (Debug.log "loginData") <~ siLoginData


{- The important one! -}
wireLogin : Signal LoginData -> Signal Action
wireLogin loginData =
  loginAction <~ Http.send (makeLoginRequest <~ loginData)

makeLoginRequest : LoginData -> Http.Request String
makeLoginRequest loginData =
  case loginData of
    ("", _) -> Http.get ""
    (_, "") -> Http.get ""
    _       -> let authHeader = Debug.log "basicAuthHeader" (basicAuthHeader loginData) in
               Http.request "get" "http://localhost:9875/login" "" [ ("Authorization", authHeader)
                                                                   , ("X-TD-Authtype", "twitter")
                                                                   ]

loginAction : Http.Response String -> Action
loginAction response =
  let res = Debug.log "response" response in
  case response of
    Http.Success str -> Step (\state -> { state | working <- False
                                                , user    <- Nothing })

    Http.Waiting     -> Step (\state -> { state | working <- True })

    Http.Failure _ _ -> Step (\state -> { state | working <- False })

    _                -> NoOp

basicAuthHeader : LoginData -> String
basicAuthHeader (username, password) =
  "x-td-basic " ++ (base64Encode <| username ++ ":" ++ password)

-- Username

loginUsernameAction : Field.Content -> Stepper
loginUsernameAction content appState =
  let login = appState.login in
  { appState | login <- { login | username <- content } }

-- Password

loginPasswordAction : Field.Content -> Stepper
loginPasswordAction content appState =
  let login = appState.login in
  { appState | login <- { login | password <- content } }

