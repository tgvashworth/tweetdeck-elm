module Interface where

import Text

-- Fonts

style : Text.Style -> String -> Text
style sty str = Text.style sty (Text.toText str)

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

cText = rgb 42 47 51
