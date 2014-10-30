module Util.Encode where

import Native.Encode

base64Encode : String -> String
base64Encode = Native.Encode.base64Encode

base64Decode : String -> String
base64Decode = Native.Encode.base64Decode
