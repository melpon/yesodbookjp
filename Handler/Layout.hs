module Handler.Layout (
  withSidebar,
  withDefault
) where

import Import

withSidebar :: Widget -> Widget
withSidebar widget =
    let contents = $(widgetFile "contents") in
    [whamlet|
<div .span3>
  ^{contents}
  <a href="@{RootR}">Home
<div .span8>
  ^{widget}
|]

withDefault :: Widget -> Widget
withDefault widget =
    [whamlet|
<div .span8>
  ^{widget}
|]
