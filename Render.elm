module Render (render) where

import Debug
import Graphics.Element (..)
import List
import Text

import Model
import Interface as I
import View.Login

render : Model.View
render appState dim =
  let
    pos = midTopAt (relative 0.5) (absolute 40)
  in
    flow down [ infoBar appState dim
              , View.Login.render appState dim
              , columns appState dim
              ]

infoBar : Model.View
infoBar appState (w,h) =
  color I.cText
    <| container w 16 topLeft
    <| flow right
    <| [ spacer 8 16
       , if appState.working then Model.spinner else empty ]

columns : Model.View
columns appState (w,h) =
  container w h topLeft
      <| flow right
      <| List.map (\c -> column c (w,h)) appState.columns

column : Model.ColumnState -> (Int, Int) -> Element
column c (w,h) =
  let _ = Debug.log "column" c in
  container 150 h topLeft
    <| flow down
    <| [ Text.leftAligned (I.style I.sBase "Column") ]
    ++ List.map (Text.leftAligned << I.style I.sBase << .content) c.chirps
