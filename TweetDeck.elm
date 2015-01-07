module TweetDeck where

{-|

TweetDeck

-}

import Window
import Model (initialAppState, AppState, Action)
import Actions (actions)
import Step (step)
import Render (render)
import Signal (..)
import Graphics.Element as Element

appState : Signal AppState
appState = foldp step initialAppState actions

main : Signal Element.Element
main = render <~ appState
               ~ Window.dimensions
