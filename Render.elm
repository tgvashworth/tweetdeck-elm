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

render : View
render state dim =
  let pos = midTopAt (relative 0.5) (absolute 40)
      appState = Debug.watch "appState" state
  in
  flow down [ Login.render state dim
            ]
