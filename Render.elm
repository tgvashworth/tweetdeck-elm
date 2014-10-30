module Render (render) where

import Debug
import Html
import Html (..)
import Html.Attributes (..)
import Html.Events (..)
import Html.Tags (..)
import Html.Optimize.RefEq as Ref

import Model
import View.Login

cText = (rgb 42 47 51)

spinner = image 16 16 "assets/loading-bubbles.svg"

render : Model.View
render state dim =
  let pos = midTopAt (relative 0.5) (absolute 40)
      appState = Debug.watch "appState" state
  in
  flow down [ infoBar state dim
            , View.Login.render state dim
            ]

infoBar : Model.View
infoBar state (w,h) =
  color cText <|
    container w 16 topLeft <|
      flow right [ spacer 8 16
                 , if state.working then spinner else empty ]
