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

code9 :: String
code9 = [rawstring|
<a href=@{Time}>The time
|]

code10 :: String
code10 = [rawstring|
\render -> mconcat ["<a href='", render Time, "'>The time</a>"]
|]

code11 :: String
code11 = [rawstring|
<body>
<p>Some paragraph.</p>
<ul>
<li>Item 1</li>
<li>Item 2</li>
</ul>
</body>
|]

code12 :: String
code12 = [rawstring|
<body>
    <p>Some paragraph.
    <ul>
        <li>Item 1
        <li>Item 2
|]

code13 :: String
code13 = [rawstring|
<p>Paragraph <i>italic</i> end.</p>
|]

code14 :: String
code14 = [rawstring|
<p>
    Paragraph #
    <i>italic
    \ end.
|]

code15 :: String
code15 = [rawstring|
<p>Paragraph <i>italic</i> end.
|]

code16 :: String
code16 = [rawstring|
<head>
    <title>#{title}
|]

code17 :: String
code17 = [rawstring|
-- shamlet による準クォートについては今は無視する。
-- それは後で説明する。
{-# LANGUAGE QuasiQuotes #-}
import Text.Hamlet (shamlet)
import Text.Blaze.Renderer.String (renderHtml)
import Data.Char (toLower)
import Data.List (sort)

data Person = Person
    { name :: String
    , age  :: Int
    }

main :: IO ()
main = putStrLn $ renderHtml [shamlet|
<p>Hello, my name is #{name person} and I am #{show $ age person}.
<p>
    Let's do some funny stuff with my name: #
    <b>#{sort $ map toLower (name person)}
<p>Oh, and in 5 years I'll be #{show $ (+) 5 (age person)} years old.
\|]
  where
    person = Person "Michael" 26
|]

code18 :: String
code18 = [rawstring|
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE OverloadedStrings #-}
import Text.Hamlet (HtmlUrl, hamlet)
import Text.Blaze.Renderer.String (renderHtml)
import Data.Text (Text)

data MyRoute = Home

render :: MyRoute -> [(Text, Text)] -> Text
render Home _ = "/home"

footer :: HtmlUrl MyRoute
footer = [hamlet|
<footer>
    Return to #
    <a href=@{Home}>Homepage
    .
\|]

main :: IO ()
main = putStrLn $ renderHtml $ [hamlet|
<body>
    <p>This is my page.
    ^{footer}
\|] render
|]

code19 :: String
code19 = [rawstring|
$if isAdmin
    <p>Welcome to the admin section.
$elseif isLoggedIn
    <p>You are not the administrator.
$else
    <p>I don't know who you are. Please log in so I can decide if you get access.
|]

code20 :: String
code20 = [rawstring|
$maybe name <- maybeName
    <p>Your name is #{name}
$nothing
    <p>I don't know your name.
|]

code21 :: String
code21 = [rawstring|
$if null people
    <p>No people.
$else
    <ul>
        $forall person <- people
            <li>#{person}
|]

code22 :: String
code22 = [rawstring|
$with foo <- (一度だけ実行されるべき、とても長くて汚い式)
    <p>しかし私は #{foo} を何度も使うだろう。#{foo}
|]

code23 :: String
code23 = [rawstring|
!!!
<html>
    <head>
        <title>Hamlet is Awesome
    <body>
        <p>All done.
|]

