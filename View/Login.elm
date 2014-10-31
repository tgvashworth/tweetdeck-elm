module View.Login where

import Graphics.Input (Input, input, button)
import Graphics.Input.Field (..)
import Text
import Dict

import Model
import Input.Login ( loginFormInputs )

textify : String -> Element
textify str = leftAligned <| Model.fBase str

render : Model.View
render state dim =
  case state.user of
        Nothing -> loginForm state dim
        Just user -> empty

loginForm : Model.View
loginForm state (w,h) =
  let pos = midTopAt (relative 0.5) (absolute 40) in
  container w h pos
    <| flow down [ textify "Login"
                 , field defaultStyle loginFormInputs.username.handle identity "Phone, email or username" state.login.username
                 , password defaultStyle loginFormInputs.password.handle identity "Password" state.login.password
                 , button loginFormInputs.action.handle () "Login"
                 ]
