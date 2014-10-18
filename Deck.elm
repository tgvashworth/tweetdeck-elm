module Deck where

import Debug
import Graphics.Input as Input
import Html
import Html (..)
import Html.Attributes (..)
import Html.Events (..)
import Html.Tags (..)
import Html.Optimize.RefEq as Ref

import Model ( AppState )

--- Exports

render : AppState -> Element
render state =
  div
    [ ]
    [ text "Deck" ]
