module Handler.Stream
  ( stream,
  )
where

import Conduit (ConduitT, (.|))
import Conduit qualified as C
import Data.Config (Config (..))
import Data.Item (Item (..))
import Effectful (Eff, (:>))
import Effectful.Reader.Static (Reader, ask)

stream :: (Reader Config :> es) => Eff es (ConduitT () Item IO ())
stream = do
  Config {name} <- ask
  pure $
    C.yieldMany [1 ..]
      .| C.takeC 10
      .| C.mapC (* 2)
      .| C.mapC (\i -> Item i name)
