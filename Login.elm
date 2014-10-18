module Login where

import Debug
import Graphics.Input (Input, input)
import Graphics.Input.Field (..)
import Text as Text

import Model ( AppState, View )
import Actions ( actions )
import Inputs ( .. )

render : View
render state (w,h) =
  case state.user of
        Nothing -> loginForm state (w,h)
        Just user -> empty

loginForm : View
loginForm state (w,h) =
  let pos = midTopAt (relative 0.5) (absolute 40) in
  container w h pos <| flow down [ header
                                 , field defaultStyle loginUsernameInput.handle identity "Phone, email or username" state.login.username
                                 , password defaultStyle loginPasswordInput.handle identity "Password" state.login.password ]

header : Element
header =
    leftAligned << Text.color (rgb 0 0 0) << Text.height 16 <| toText "Login"
