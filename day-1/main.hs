module Main where

import Data.List (sortBy)

import qualified Data.Text as T

readInputFile :: String -> [String]
readInputFile cs = map T.unpack (T.splitOn (T.pack "\n\n") (T.pack cs))

toCalories :: [String] -> [[Int]]
toCalories = map (map read . lines)

solve :: [[Int]] -> Int
solve = maximum . map sum

solve' :: [[Int]] -> String
solve' = show . take 3 . sortBy (flip compare) . map sum

main :: IO ()
main = do
  contents <- readFile "./input.txt"
  print $ solve $ toCalories $ readInputFile contents
  print $ solve' $ toCalories $ readInputFile contents

