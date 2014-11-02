module Api.Login where

import Dict
import Http
import Json

import Util.Encode

import Model ( .. )

data LoginResponse
  = Waiting
  | Failure Int String
  | Success (Maybe AuthedUser)

-- Login API Request

doLogin : Signal LoginData -> Signal Action
doLogin loginData =
  makeLoginAction <~ (processLoginRepsonse <~ Http.send (makeLoginRequest <~ loginData))

makeLoginAction : LoginResponse -> Action
makeLoginAction res =
  case res of
    (Success (Just user)) ->
      Step (\state -> { state | working <- False
                              , user    <- Just user })
    Waiting ->
      Working True
    _ ->
      Working False

makeLoginRequest : LoginData -> Http.Request String
makeLoginRequest loginData =
  case loginData of
    ("", _) -> Http.get ""
    (_, "") -> Http.get ""
    _       -> let authHeader = basicAuthHeader loginData in
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

basicAuthHeader : LoginData -> String
basicAuthHeader (username, password) =
  "x-td-basic " ++ (Util.Encode.base64Encode <| username ++ ":" ++ password)
