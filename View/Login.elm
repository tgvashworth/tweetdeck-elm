module View.Login where

import Graphics.Input (Input, input, button)
import Graphics.Input.Field (..)
import Text
import Dict

import Model
import Interface as I
import Input.Login ( loginFormInputs )

render : Model.View
render appState dim =
  case appState.user of
    Nothing   -> loginForm appState dim
    Just user -> empty

loginForm : Model.View
loginForm appState (w,h) =
  let
    pos = midTopAt (relative 0.5) (absolute 40)
  in
    container w h pos
      <| flow down
      <| intersperse
          (spacer 5 5)
          [ leftAligned (I.style I.sTitle "Login")
          , field defaultStyle loginFormInputs.username.handle identity "Phone, email or username" appState.login.username
          , password defaultStyle loginFormInputs.password.handle identity "Password" appState.login.password
          , button loginFormInputs.action.handle () "Login"
          ]
