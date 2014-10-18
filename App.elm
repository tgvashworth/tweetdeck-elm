module App where

import Types
import Types (..)

import User
import Column
import Compose

type State =
    { user    : Maybe User.AuthedUser
    , columns : [Column.State]
    , compose : Compose.State
    }

data Action
    = NoOp
    | User.Action
    | Column.Action
    | Compose.Action

emptyState : State
emptyState =
    { user    = Nothing
    , columns = Column.emptyState
    , compose = Compose.emptyState
    }

step : Action -> State -> State
step action step = action step
