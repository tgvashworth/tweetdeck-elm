module Login where

import Debug
import Graphics.Input (Input, input, button)
import Graphics.Input.Field (..)
import Text as Text

import Model ( AppState, View )
import Actions ( actions )
import Inputs ( loginInputs )

render : View
render state dim =
  case state.user of
        Nothing -> loginForm state dim
        Just user -> empty

loginForm : View
loginForm state (w,h) =
  let pos = midTopAt (relative 0.5) (absolute 40) in
  container w h pos <| flow down [ leftAligned << Text.color (rgb 0 0 0) << Text.height 16 <| toText "Login"
                                 , field defaultStyle loginInputs.username.handle identity "Phone, email or username" state.login.username
                                 , password defaultStyle loginInputs.password.handle identity "Password" state.login.password
                                 , button loginInputs.action.handle state.login "Login"
                                 ]
