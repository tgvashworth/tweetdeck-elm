module Model where

import Graphics.Input.Field as Field
import Graphics.Input as Input

--- USER

type UserId     = String
type ScreenName = String

type User =
  { id        : UserId
  , screename : ScreenName
  , name      : String
  }

type Tokens = (String, String)

type AuthedUser =
  { user   : User
  , tokens : Tokens
  }

initialUserState = Nothing

temporaryFakeAuthedUserState =
  { user   = { id        = "12345"
             , screename = "tom"
             , name      = "Tom"
             }
  , tokens = ("12345-abc123xyz456","aioah3r989q3xy88x3")
  }

--- COLUMN

type Chirp =
  { content : String
  }

type ColumnState =
  { chirps : [Chirp]
  }

initialColumnsState = []

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

--- STATE

type AppState =
  { user    : Maybe AuthedUser
  , columns : [ColumnState]
  , compose : ComposeState
  , login   : LoginState
  }

initialAppState =
  { user    = initialUserState
  , columns = initialColumnsState
  , compose = initialComposeState
  , login   = initialLoginState
  }

--- ACTIONS

type Stepper = AppState -> AppState

data Action
  = NoOp
  | Login
  | Step Stepper

type InputStepper a =
  { input  : Input.Input a
  , action : a -> Stepper
  }

type InputAction a =
  { input  : Input.Input a
  , action : a -> Action
  }

--- VIEW

type View = AppState -> (Int,Int) -> Element
