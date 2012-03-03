module RawString (
  rawstring
) where

import Import
import Language.Haskell.TH
import Language.Haskell.TH.Quote

rawstring :: QuasiQuoter
rawstring = QuasiQuoter { quoteExp = litE . StringL }

