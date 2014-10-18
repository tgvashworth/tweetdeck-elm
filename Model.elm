module Model where

import Graphics.Input.Field as Field

--- USER

type UserId     = String
type ScreenName = String

type User =
  { id         : UserId
  , screenanme : ScreenName
  , name       : String
  }

type Tokens = (String, String)

type AuthedUser =
  { user   : User
  , tokens : Tokens
  }

--- COLUMN

type Chirp =
  { content : String
  }

type ColumnState =
  { chirps : [Chirp]
  }

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
  { user    = Nothing
  , columns = []
  , compose = initialComposeState
  , login   = initialLoginState
  }

--- ACTIONS

type Stepper = AppState -> AppState

data Action
  = NoOp
  | Step Stepper

--- VIEW

type View = AppState -> (Int,Int) -> Element
