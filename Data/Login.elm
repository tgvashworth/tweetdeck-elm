module Data.Login where

import Debug
import Dict
import Http
import Json

import Util.Encode

import Model ( .. )
import Input.Login

data LoginResponse
  = Waiting
  | Failure Int String
  | Success (Maybe AuthedUser)

-- Utils

basicAuthHeader : LoginData -> String
basicAuthHeader (username, password) =
  "X-TD-Basic " ++ (Util.Encode.base64Encode <| username ++ ":" ++ password)

sessionHeader : AuthedUser -> String
sessionHeader {user,session} =
  "X-TD-Session " ++ session

-- Login API Request

actions : [Signal Action]
actions =
    [ siLoginAction
    , delay (1 * millisecond) siInitialLoadAction ]
    ++
    Input.Login.actions

-- Login response signals

siLoginResponse : Signal LoginResponse
siLoginResponse = processLoginRepsonse <~ Http.send (makeLoginRequest <~ Input.Login.siLoginData)

siLoginAction : Signal Action
siLoginAction = makeLoginAction <~ siLoginResponse

-- Initial load signals

siInitialLoad : Signal (Maybe Bool)
siInitialLoad = processInitialLoadResponse <~ Http.send (makeInitiaLoadRequest <~ siLoginResponse)

siInitialLoadAction : Signal Action
siInitialLoadAction = makeInitialLoadAction <~ siInitialLoad

-- Login

makeLoginAction : LoginResponse -> Action
makeLoginAction res =
  case res of
    Success (Just user) ->
      Step (\state -> { state | working <- False
                              , user    <- Just user })
    Waiting ->
      Working True
    _ ->
      Working False

makeLoginRequest : LoginData -> Http.Request String
makeLoginRequest loginData =
  case loginData of
    ("", _) ->
      Http.get ""
    (_, "") ->
      Http.get ""
    _ ->
      let authHeader = basicAuthHeader loginData in
      Http.request "get" "http://localhost:9875/login" "" [ ("Authorization", authHeader)
                                                          , ("X-TD-Authtype", "twitter")
                                                          ]

processLoginRepsonse : Http.Response String -> LoginResponse
processLoginRepsonse res =
  case res of
    Http.Success str ->
      Success (processLoginJson (Json.fromString str))
    Http.Waiting ->
      Waiting
    Http.Failure a b ->
      Failure a b

processLoginJson : Maybe Json.Value -> Maybe AuthedUser
processLoginJson json =
  case json of
    Just (Json.Object userObject) ->
      makeAuthedUser userObject
    _ ->
      Nothing

makeAuthedUser : Dict.Dict String Json.Value -> Maybe AuthedUser
makeAuthedUser userObject =
  case ((,,) (Dict.get "user_id" userObject)
             (Dict.get "screen_name" userObject)
             (Dict.get "session" userObject)) of
    (Just (Json.String id), Just (Json.String screenname), Just (Json.String session)) ->
      (Just (makeUser id screenname session))
    _ -> Nothing

-- Initial load

makeInitialLoadAction : Maybe Bool -> Action
makeInitialLoadAction _ = NoOp

makeInitiaLoadRequest : LoginResponse -> Http.Request String
makeInitiaLoadRequest loginResponse =
  case loginResponse of
    Success (Just user) ->
      let authHeader = sessionHeader user
          _ = Debug.log "authHeader" authHeader
      in
      Http.request "get" "http://localhost:9875/clients/blackbird/all" "" [ ("Authorization", authHeader) ]
    _ ->
      Http.get ""

processInitialLoadResponse : Http.Response String -> Maybe Bool
processInitialLoadResponse processInitialLoadResponse =
  let _ = Debug.log "processInitialLoadResponse" processInitialLoadResponse in (Just False)
