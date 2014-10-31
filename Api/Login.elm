module Api.Login where

import Dict
import Http
import Json

import Util.Encode

import Model ( .. )

-- Login API Request

doLogin : Signal LoginData -> Signal Action
doLogin loginData =
  loginAction <~ Http.send (makeLoginRequest <~ loginData)

makeLoginRequest : LoginData -> Http.Request String
makeLoginRequest loginData =
  case loginData of
    ("", _) -> Http.get ""
    (_, "") -> Http.get ""
    _       -> let authHeader = basicAuthHeader loginData in
               Http.request "get" "http://localhost:9875/login" "" [ ("Authorization", authHeader)
                                                                   , ("X-TD-Authtype", "twitter")
                                                                   ]

loginAction : Http.Response String -> Action
loginAction response =
  case response of
    Http.Success str -> loginUser (Json.fromString str)
    Http.Waiting     -> Working True
    Http.Failure _ _ -> Working False

loginUser : Maybe Json.Value -> Action
loginUser userData =
  case userData of
    Just (Json.Object userObject) ->
      case (makeAuthedUser userObject) of
        Just user -> Step (\state -> { state | working <- False
                                             , user    <- Just user })
        Nothing   -> Working False
    _ -> Working False

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
