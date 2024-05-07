module Data.Item (Item (..)) where

import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics (Generic)

data Item = Item
  { itemId :: Integer,
    itemText :: String
  }
  deriving (Eq, Show, Generic)

instance ToJSON Item

instance FromJSON Item
