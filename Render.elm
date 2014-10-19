module Render (render) where

import Debug
import Html
import Html (..)
import Html.Attributes (..)
import Html.Events (..)
import Html.Tags (..)
import Html.Optimize.RefEq as Ref

import Model ( AppState, View )
import Login

cText = (rgb 42 47 51)

spinner = image 16 16 "loading-bubbles.svg"

render : View
render state dim =
  let pos = midTopAt (relative 0.5) (absolute 40)
      appState = Debug.watch "appState" state
  in
  flow down [ infoBar state dim
            , Login.render state dim
            ]

infoBar : View
infoBar state (w,h) =
  color cText <|
    container w 16 topLeft <|
      flow right [ spacer 8 16
                 , if state.working then spinner else empty ]
