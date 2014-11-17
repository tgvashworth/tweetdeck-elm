module Model where

import Graphics.Input.Field as Field
import Graphics.Input as Input
import Dict

--- STATE

type AppState =
  { user    : Maybe AuthedUser
  , columns : [ColumnState]
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

type UserId     = String
type ScreenName = String

type User =
  { id        : UserId
  , screename : ScreenName
  }

type Session = String

type AuthedUser =
  { user    : User
  , session : String
  }

initialUserState = Nothing

makeUser : String -> String -> String -> AuthedUser
makeUser id screename session =
  { user = { id = id, screename = screename }, session = session }

--- COLUMN

type Chirp =
  { content : String
  }

type ColumnState =
  { chirps : [Chirp]
  }

initialColumnsState = []

makeColumn : [Chirp] -> ColumnState
makeColumn chirps =
  { chirps = chirps }

makeChirp : String -> Chirp
makeChirp content =
  { content = content }

--- COMPOSE

type ComposeState =
  { text : String
  }

initialComposeState =
  { text = ""
  }

--- LOGIN

type LoginState =
  { username : Field.Content
  , password : Field.Content
  }

initialLoginState =
  { username = Field.noContent
  , password = Field.noContent
  }

type LoginData = (String, String)

--- ACTIONS

type Stepper = AppState -> AppState

data Action
  = NoOp
  | Working Bool
  | Login
  | Step Stepper

type InputStepper a =
  { input  : Input.Input a
  , action : a -> Stepper
  }

makeStep : Signal Stepper -> Signal Action
makeStep = lift Step

--- VIEW

type View = AppState -> (Int,Int) -> Element

-- Assets

spinner = image 16 16 "assets/loading-bubbles.svg"
