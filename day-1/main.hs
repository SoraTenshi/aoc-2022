module Main where

import System.FilePath
import Data.Text.Lazy (splitOn)

import qualified Data.Text as T

readInputFile :: String -> [String]
readInputFile cs = map T.unpack (T.splitOn (T.pack "\n\n") (T.pack cs))

toCalories :: [String] -> [Int]
toCalories = map ((sum . map read) . lines)

solve :: [Int] -> Int
solve = maximum 

main :: IO ()
main = do
  contents <- readFile "./input.txt"
  print $ solve $ toCalories $ readInputFile contents
