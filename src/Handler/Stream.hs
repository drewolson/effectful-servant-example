module Handler.Stream
  ( stream,
  )
where

import Conduit (ConduitT, (.|))
import Conduit qualified as C
import Data.Config (Config (..))
import Data.Item (Item (..))
import Effectful (Eff, IOE, UnliftStrategy (..), (:>))
import Effectful qualified as E
import Effectful.Concurrent (Concurrent, threadDelay)
import Effectful.Reader.Static (Reader, ask)

pause :: (Concurrent :> es) => Eff es ()
pause = threadDelay 100000

mkItem :: (Reader Config :> es) => Integer -> Eff es Item
mkItem i = do
  Config {name} <- ask

  pure $ Item i name

stream :: (IOE :> es, Concurrent :> es, Reader Config :> es) => Eff es (ConduitT () Item IO ())
stream = do
  E.withEffToIO SeqForkUnlift $ \runIO ->
    pure $
      C.yieldMany [1 ..]
        .| C.takeC 10
        .| C.mapC (* 2)
        .| C.iterMC (const $ runIO $ pause)
        .| C.mapMC (runIO . mkItem)
