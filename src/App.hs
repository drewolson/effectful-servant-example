module App
  ( App,
    runApp,
  )
where

import Data.Config (Config (..))
import Effectful (Eff, IOE, runEff)
import Effectful.Error.Static (CallStack, Error, runError)
import Effectful.Reader.Static (Reader, runReader)
import Servant (ServerError)

type App = Eff '[Reader Config, Error ServerError, IOE]

runApp :: Config -> App a -> IO (Either (CallStack, ServerError) a)
runApp config = runEff . runError . runReader config
