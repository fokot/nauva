{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}

module Nauva.Product.Template.App (app) where


import qualified Data.Text as T

import           Nauva.App
import           Nauva.Internal.Types
import           Nauva.View

import           Language.Haskell.TH



app :: App
app = App
    { rootElement = \appH -> constHead (headH appH) headElements $ div_ [style_ style]
        [ header
        , intro
        ]
    }

  where
    headElements =
        [ style_ [str_ "*,*::before,*::after{box-sizing:inherit}body{margin:0;box-sizing:border-box;font-family:-apple-system, BlinkMacSystemFont, \"Segoe UI\", Roboto, Helvetica, Arial, sans-serif, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\"}"]
        ]

    style = mkStyle $ do
        textAlign center


header :: Element
header = div_ [style_ style]
    [ h1_ [str_ "Welcome to Nauva"]
    ]
  where
    style = mkStyle $ do
        backgroundColor "#222"
        height "150px"
        padding "20px"
        color "white"

        onHover $ do
            color "red"

intro :: Element
intro = p_ [style_ style]
    [ str_ "To get started, edit "
    , code_ [str_ $ T.pack file]
    , str_ " and save to reload."
    ]
  where
    style = mkStyle $ do
        fontSize "large"

    file :: String
    file = $(do
        loc <- location
        let s = loc_filename loc
        [| s |]
      )
