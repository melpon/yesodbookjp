module Handler.Introduction where

import Import

getIntroductionR :: Handler RepHtml
getIntroductionR = do
    defaultLayout $ do
        setTitle "Introduction"
        $(widgetFile "introduction")
        $(widgetFile "description")
