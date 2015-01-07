module View.Login where

import Graphics.Element (..)
import Graphics.Input (..)
import Graphics.Input.Field (..)
import Text
import Dict
import List (..)
import Signal (..)

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
          [ Text.leftAligned (I.style I.sTitle "Login")
          , field defaultStyle (send loginFormInputs.username) "Phone, email or username" appState.login.username
          , password defaultStyle (send loginFormInputs.password) "Password" appState.login.password
          , button (send loginFormInputs.action ()) "Login"
          ]
