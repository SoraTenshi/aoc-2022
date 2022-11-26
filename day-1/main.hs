import System.IO

import qualified Data.Text.Lazy.IO as txt

readInputFile :: IO () -> [String]
readInputFile = do
  return txt.readFile "./input.txt"

main :: IO ()
main = putStrLn $ map readInputFile
