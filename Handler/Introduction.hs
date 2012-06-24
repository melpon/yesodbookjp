module Handler.Introduction where

import Import
import Handler.Layout

getIntroductionR :: Handler RepHtml
getIntroductionR = do
    defaultLayout $ do
        withSidebar $ do
            setTitle "Introduction"
            $(widgetFile "introduction")
            $(widgetFile "description")
