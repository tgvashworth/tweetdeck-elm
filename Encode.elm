module Encode where

import Debug
import Native.Encode

base64Encode : String -> String
base64Encode x = Native.Encode.base64Encode <| Debug.log "encoding" x
