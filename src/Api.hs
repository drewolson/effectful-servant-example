module Api
  ( Api,
    server,
  )
where

import App (App)
import Data.Item (Item)
import Handler.Item qualified
import Servant (Capture, Get, HasServer (ServerT), JSON, (:<|>) (..), (:>))

type Api =
  "item" :> Get '[JSON] [Item]
    :<|> "item" :> Capture "itemId" Integer :> Get '[JSON] Item

server :: ServerT Api App
server =
  Handler.Item.getItems
    :<|> Handler.Item.getItemById
