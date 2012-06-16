module Handler.Session (
  getSessionR
) where

import Import
import RawString

getSessionR :: Handler RepHtml
getSessionR = do
    defaultLayout $ do
        setTitle "Session"
        $(widgetFile "session")
        $(widgetFile "description")

