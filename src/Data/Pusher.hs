module Data.Pusher (Pusher(..), Credentials(..)) where

import Data.Aeson ((.:))
import Data.Text.Encoding (encodeUtf8)
import Control.Applicative ((<$>), (<*>))
import qualified Data.Aeson as A
import qualified Data.ByteString as B
import qualified Data.Text as T

import Pusher.Util (failExpectObj)

data Pusher = Pusher
  { pusher'host :: T.Text
  , pusher'path :: T.Text
  , pusher'credentials :: Credentials
  }

data Credentials = Credentials
  { credentials'appID :: Integer
  , credentials'appKey :: B.ByteString
  , credentials'appSecret :: B.ByteString
  }

instance A.FromJSON Credentials where
  parseJSON (A.Object v) = Credentials
    <$> v .: "app-id"
    <*> (encodeUtf8 <$> v .: "app-key")
    <*> (encodeUtf8 <$> v .: "app-secret")
  parseJSON v2 = failExpectObj v2