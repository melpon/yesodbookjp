module Handler.Shakespeare (
  getShakespeareR
) where

import Import
import RawString

getShakespeareR :: Handler RepHtml
getShakespeareR = do
    defaultLayout $ do
        setTitle "Shakespeare"
        $(widgetFile "shakespeare")
        $(widgetFile "description")



code1 :: String
code1 = [rawstring|
!!!
<html>
    <head>
        <title>#{pageTitle} - My Site
        <link rel=stylesheet href=@{Stylesheet}>
    <body>
        <h1 .page-title>#{pageTitle}
        <p>Here is a list of your friends:
        $if null friends
            <p>Sorry, I lied, you don't have any friends.
        $else
            <ul>
                $forall friend <- friends
                    <li>#{friendName friend} (#{friendAge friend} years old)
        <footer>^{copyright}
|]

code2 :: String
code2 = [rawstring|#myid
    color: #{red}
    font-size: #{bodyFontSize}
foo bar baz
    background-image: url(@{MyBackgroundR})
|]

code3 :: String
code3 = [rawstring|
section.blog {
    padding: 1em;
    border: 1px solid #000;
    h1 {
        color: #{headingColor};
    }
}
|]

code4 :: String
code4 = [rawstring|
$(function(){
    $("section.#{sectionClass}").hide();
    $("#mybutton").click(function(){document.location = "@{SomeRouteR}";});
    ^{addBling}
});
|]

code5 :: String
code5 = [rawstring|
<p>Hello, my name is #{name}
|]

code6 :: String
code6 = [rawstring|
data MyRoute = Home | Time
|]

code7 :: String
code7 = [rawstring|
renderMyRoute :: MyRoute -> Text
renderMyRoute Home = "http://example.com/profile/home"
renderMyRoute Time = "http://example.com/display/time"
|]

code8 :: String
code8 = [rawstring|
type Query = [(Text, Text)]
type Render url = url -> Query -> Text
renderMyRoute :: Render MyRoute
renderMyRoute Home _ = ...
renderMyRoute Time _ = ...
|]
