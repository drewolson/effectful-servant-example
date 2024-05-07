module Api
  ( Api,
    server,
  )
where

import App (App)
import Conduit (ConduitT)
import Data.Item (Item)
import Handler.Item qualified
import Handler.Stream qualified
import Servant
  ( Capture,
    Get,
    HasServer (ServerT),
    JSON,
    NewlineFraming,
    StreamGet,
    (:<|>) (..),
    (:>),
  )

type Api =
  "item" :> Get '[JSON] [Item]
    :<|> "item" :> Capture "itemId" Integer :> Get '[JSON] Item
    :<|> "stream" :> StreamGet NewlineFraming JSON (ConduitT () Item IO ())

server :: ServerT Api App
server =
  Handler.Item.getItems
    :<|> Handler.Item.getItemById
    :<|> Handler.Stream.stream
