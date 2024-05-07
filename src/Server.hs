module Server
  ( run,
  )
where

import Api (Api)
import Api qualified
import App qualified
import Control.Monad.Except (ExceptT (..))
import Data.Bifunctor (Bifunctor (first))
import Data.Config (Config (..))
import Effectful.Error.Static (CallStack)
import Network.Wai.Handler.Warp qualified as W
import Servant
  ( Application,
    Handler (..),
    Proxy (..),
    ServerError,
  )
import Servant qualified as S
import Servant.Conduit ()
import System.IO

toHandler :: IO (Either (CallStack, ServerError) a) -> Handler a
toHandler = Handler . ExceptT . fmap (first snd)

mkApp :: Config -> Application
mkApp config =
  S.serve (Proxy @Api) $
    S.hoistServer (Proxy @Api) (toHandler . App.runApp config) Api.server

run :: IO ()
run = do
  let port = 3000
  let startMessage = hPutStrLn stderr ("listening on port " ++ show port)
  let settings =
        W.setPort port
          . W.setBeforeMainLoop startMessage
          $ W.defaultSettings
  let config = Config {name = "Drew"}
  let app = mkApp config

  W.runSettings settings app
