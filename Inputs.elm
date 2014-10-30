module Inputs where

import Debug
import Dict
import Http
import Graphics.Input ( Input, input )
import Graphics.Input.Field as Field
import JavaScript.Experimental as JS
import Json

import Encode ( base64Encode )

import Model ( .. )
import Input.Login

inputs : [Signal Action]
inputs =
  Input.Login.inputs

