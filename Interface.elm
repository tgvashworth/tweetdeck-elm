module Interface where

import Text
import Color

-- Fonts

style : Text.Style -> String -> Text.Text
style sty str = Text.style sty (Text.fromString str)

fSizeBase = 16

sDefault : Text.Style
sDefault = Text.defaultStyle

sBase : Text.Style
sBase =
  { sDefault | color  <- cText
             , height <- Just fSizeBase
  }

sTitle : Text.Style
sTitle =
  { sBase | height <- Just (fSizeBase * 1.5)
  }

-- Colors

cText = Color.rgb 42 47 51
