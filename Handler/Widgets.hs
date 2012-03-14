module Handler.Widgets (
  getWidgetsR
) where

import Import
import RawString

getWidgetsR :: Handler RepHtml
getWidgetsR = do
    defaultLayout $ do
        setTitle "Widgets"
        $(widgetFile "widgets")
        $(widgetFile "description")



code1 :: String
code1 = [rawstring|
getRootR = defaultLayout $ do
    setTitle "My Page Title"
    toWidget [lucius| h1 { color: green; } ｜］
    addScriptRemote "https://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"
    toWidget [julius|
$(function() {
    $("h1").click(function(){ alert("You clicked on the heading!"); });
});
｜］
    toWidgetHead [hamlet| <meta name=keywords content="some sample keywords">｜］
    toWidget [hamlet| <h1>Here's one way of including content ｜］
    [whamlet| <h2>Here's another ｜］
    toWidgetBody [julius| alert("This is included in the body itself"); ｜］
|]

code2 :: String
code2 = [rawstring|
<!DOCTYPE html> 
<html>
    <head>
        <title>My Page Title</title>
        <style>h1 { color : green }</style>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
        <script>
$(function() {
    $("h1").click(function(){ alert("You clicked on the heading!"); });
});
</script>
        <meta name="keywords" content="some sample keywords">
    </head>
    <body>
        <h1>Here's one way of including content </h1>
        <h2>Here's another </h2>
        <script> alert("This is included in the body itself"); </script>
    </body>
</html>
|]

code3 :: String
code3 = [rawstring|
myWidget1 = do
    toWidget [hamlet|<h1>My Title｜］
    toWidget [lucius|h1 { color: green } ｜］

myWidget2 = do
    setTitle "My Page Title"
    addScriptRemote "http://www.example.com/script.js"

myWidget = do
    myWidget1
    myWidget2

-- あるいはこう書いてもいい
myWidget' = myWidget1 >> myWidget2
|]

code4 :: String
code4 = [rawstring|
getRootR = defaultLayout $ do
    headerClass <- lift newIdent
    toWidget [hamlet|<h1 .#{headerClass}>My Header｜］
    toWidget [lucius| .#{headerClass} { color: green; } ｜］
|]

code5 :: String
code5 = [rawstring|
page = [hamlet|
<p>This is my page. I hope you enjoyed it.
^{footer}
｜］

footer = [hamlet|
<footer>
    <p>That's all folks!
｜］
|]

code6 :: String
code6 = [rawstring|
footer = do
    toWidget [lucius| footer { font-weight: bold; text-align: center } ｜］
    toWidget [hamlet|
<footer>
    <p>That's all folks!
｜］
|]

code7 :: String
code7 = [rawstring|
page = [whamlet|
<p>This is my page. I hope you enjoyed it.
^{footer}
｜］
|]

code8 :: String
code8 = [rawstring|
footer :: Widget
footer = do
    toWidget [lucius| footer { font-weight: bold; text-align: center } ｜］
    toWidget [hamlet|
<footer>
    <p>That's all folks!
｜］

page :: Widget
page = [whamlet|
<p>This is my page. I hope you enjoyed it.
^{footer}
｜］
|]


