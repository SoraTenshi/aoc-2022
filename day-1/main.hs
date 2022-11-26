module Main where

import System.IO
import System.FilePath

readInputFile :: FilePath -> IO [String]
readInputFile = fmap lines . readFile

main :: IO ()
main = mapM_ putStrLn =<< readInputFile "./input.txt"
