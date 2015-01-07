module Model where

import Graphics.Element as Element
import Graphics.Input.Field as Field
import Dict
import Signal (..)

--- STATE

type alias AppState =
  { user    : Maybe AuthedUser
  , columns : List ColumnState
  , compose : ComposeState
  , login   : LoginState
  , working : Bool
  }

initialAppState =
  { user    = initialUserState
  , columns = initialColumnsState
  , compose = initialComposeState
  , login   = initialLoginState
  , working = False
  }

--- USER

type alias UserId     = String
type alias ScreenName = String

type alias User =
  { id        : UserId
  , screename : ScreenName
  }

type alias Session = String

type alias AuthedUser =
  { user    : User
  , session : String
  }

initialUserState = Nothing

makeUser : String -> String -> String -> AuthedUser
makeUser id screename session =
  { user = { id = id, screename = screename }, session = session }

--- COLUMN

type alias Chirp =
  { content : String
  }

type alias ColumnState =
  { chirps : List Chirp
  }

initialColumnsState = []

makeColumn : List Chirp -> ColumnState
makeColumn chirps =
  { chirps = chirps }

makeChirp : String -> Chirp
makeChirp content =
  { content = content }

--- COMPOSE

type alias ComposeState =
  { text : String
  }

initialComposeState =
  { text = ""
  }

--- LOGIN

type alias LoginState =
  { username : Field.Content
  , password : Field.Content
  }

initialLoginState =
  { username = Field.noContent
  , password = Field.noContent
  }

type alias LoginData = (String, String)

--- ACTIONS

type alias Stepper = AppState -> AppState

type Action
  = NoOp
  | Working Bool
  | Login
  | Step Stepper

type alias InputStepper a =
  { input  : Channel a
  , action : a -> Stepper
  }

makeStep : Signal Stepper -> Signal Action
makeStep = map Step

--- VIEW

type alias View = AppState -> (Int,Int) -> Element.Element

-- Assets

spinner = Element.image 16 16 "assets/loading-bubbles.svg"
