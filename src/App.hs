module App
  ( App,
    runApp,
  )
where

import Data.Config (Config (..))
import Effectful (Eff, runPureEff)
import Effectful.Error.Static (CallStack, Error, runError)
import Effectful.Reader.Static (Reader, runReader)
import Servant (ServerError)

type App = Eff '[Reader Config, Error ServerError]

runApp :: Config -> App a -> IO (Either (CallStack, ServerError) a)
runApp config = pure . runPureEff . runError . runReader config
