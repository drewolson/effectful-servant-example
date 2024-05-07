module Handler.Item
  ( getItems,
    getItemById,
  )
where

import Data.Config (Config (..))
import Data.Item (Item (..))
import Effectful (Eff, (:>))
import Effectful.Error.Static (Error, throwError)
import Effectful.Reader.Static (Reader, ask)
import Servant (ServerError)
import Servant qualified as S

getItems :: (Reader Config :> es) => Eff es [Item]
getItems = do
  Config {name} <- ask
  let item = exampleItem name
  return [item]

getItemById :: (Reader Config :> es, Error ServerError :> es) => Integer -> Eff es Item
getItemById itemId = do
  Config {name} <- ask
  let item = exampleItem name
  case itemId of
    0 -> return item
    _ -> throwError S.err404

exampleItem :: String -> Item
exampleItem name = Item 0 name
