module Foundation
    ( YesodBookJP (..)
    , Route (..)
    , resourcesYesodBookJP
    , Handler
    , Widget
    , module Yesod.Core
    , module Settings
    , liftIO
    ) where

import Prelude
import Yesod.Core hiding (Route)
import Yesod.Default.Config
import Yesod.Default.Util (addStaticContentExternal)
import Yesod.Static
import Settings.StaticFiles
import Yesod.Logger (Logger, logMsg, formatLogText)
import qualified Settings
import Settings (widgetFile)
import Control.Monad.IO.Class (liftIO)
import Web.ClientSession (getKey)
import Text.Hamlet (hamletFile)
import Text.Jasmine (minifym)

-- | The site argument for your application. This can be a good place to
-- keep settings and values requiring initialization before your application
-- starts running, such as database connections. Every handler will have
-- access to the data present here.
data YesodBookJP = YesodBookJP
    { settings  :: AppConfig DefaultEnv ()
    , getLogger :: Logger
    , getStatic :: Static -- ^ Settings for static file serving.
    }

-- This is where we define all of the routes in our application. For a full
-- explanation of the syntax, please see:
-- http://docs.yesodweb.com/book/web-routes-quasi/
--
-- This function does three things:
--
-- * Creates the route datatype YesodBookJPRoute. Every valid URL in your
--   application can be represented as a value of this type.
-- * Creates the associated type:
--       type instance Route YesodBookJP = YesodBookJPRoute
-- * Creates the value resourcesYesodBookJP which contains information on the
--   resources declared below. This is used in Handler.hs by the call to
--   mkYesodDispatch
--
-- What this function does *not* do is create a YesodSite instance for
-- YesodBookJP. Creating that instance requires all of the handler functions
-- for our application to be in scope. However, the handler functions
-- usually require access to the YesodBookJPRoute datatype. Therefore, we
-- split these actions into two functions and place them in separate files.
mkYesodData "YesodBookJP" $(parseRoutesFile "config/routes")

-- Please see the documentation for the Yesod typeclass. There are a number
-- of settings which can be configured by overriding methods here.
instance Yesod YesodBookJP where
    approot = ApprootMaster $ appRoot . settings

    -- Store session data on the client in encrypted cookies,
    -- default session idle timeout is 120 minutes
    makeSessionBackend _ = do
        key <- getKey "config/client_session_key.aes"
        return . Just $ clientSessionBackend key 120

    defaultLayout widget = do
        master <- getYesod
        mmsg <- getMessage

        -- We break up the default layout into two components:
        -- default-layout is the contents of the body tag, and
        -- default-layout-wrapper is the entire page. Since the final
        -- value passed to hamletToRepHtml cannot be a widget, this allows
        -- you to use normal widget features in default-layout.

        pc <- widgetToPageContent $ do
            $(widgetFile "default-layout")
            addStylesheet $ StaticR $ bootstrap_css_bootstrap_min_css
        hamletToRepHtml $(hamletFile "templates/default-layout-wrapper.hamlet")

    -- This is done to provide an optimization for serving static files from
    -- a separate domain. Please see the staticroot setting in Settings.hs
    urlRenderOverride y (StaticR s) =
        Just $ uncurry (joinPath y (Settings.staticRoot $ settings y)) $ renderRoute s
    urlRenderOverride _ _ = Nothing

    -- The page to be redirected to when authentication is required.
    -- authRoute _ = Just $ AuthR LoginR

    messageLogger y loc level msg =
      formatLogText (getLogger y) loc level msg >>= logMsg (getLogger y)

    -- This function creates static content files in the static folder
    -- and names them based on a hash of their content. This allows
    -- expiration dates to be set far in the future without worry of
    -- users receiving stale content.
    addStaticContent = addStaticContentExternal minifym base64md5 Settings.staticDir (StaticR . flip StaticRoute [])

    -- Place Javascript at bottom of the body tag so the rest of the page loads first
    jsLoader _ = BottomOfBody
