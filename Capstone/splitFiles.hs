module Main where

import           System.Environment (getArgs)

import           Prelude            hiding (lines, readFile, writeFile)

import           Control.Monad      (foldM_)
import           Data.Text.Lazy     (Text, lines, toLower)
import           Data.Text.Lazy.IO  (readFile, writeFile)
import           Text.Printf        (printf)

writeDoc :: FilePath -> Int -> Text -> IO Int
writeDoc dir serial doc = do
     writeFile file $ toLower doc
     --putStrLn filename
     return $ serial + 1
     where
         serialstr = printf "%07d" serial
         file = dir ++ "/" ++ serialstr


test a = head a

main :: IO ()
main = do
    args <- getArgs
    let
        file = args !! 0
        target = args !! 1
        in do
    	    docs <- readFile file
    	    foldM_ (writeDoc target) 1 $ lines docs
