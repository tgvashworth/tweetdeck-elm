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


render : Model.View
render appState dim =
  let pos = midTopAt (relative 0.5) (absolute 40)
  in flow down [ infoBar appState dim
               , View.Login.render appState dim
               ]

infoBar : Model.View
infoBar appState (w,h) =
  color Model.cText <|
    container w 16 topLeft <|
      flow right [ spacer 8 16
                 , if appState.working then Model.spinner else empty ]
