module TweetDeck where

{-|

TweetDeck

-}

import Window
import Model (initialAppState, AppState, Action)
import Inputs (inputs)
import Step (step)
import Render (render)

appState : Signal AppState
appState = foldp step initialAppState inputs

main : Signal Element
main = render <~ appState
               ~ Window.dimensions
