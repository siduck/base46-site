{-# LANGUAGE DeriveFunctor, DeriveFoldable, DeriveTraversable #-}

import Data.Map (Map, fromList, toList)
import Data.List (foldl')
import Text.Printf (printf)

-- Define a data type to hold complex data
data ComplexData = ComplexData
  { id :: Int
  , name :: String
  , values :: [Int]
  } deriving (Show)

-- Create a new instance of ComplexData
newComplexData :: Int -> String -> ComplexData
newComplexData id name = ComplexData id name [id * 10, id * 20, id * 30]

-- Calculate the average of values in ComplexData
calculate :: ComplexData -> Double
calculate (ComplexData _ _ values) = 
  fromIntegral (sum values) / fromIntegral (length values)

-- Generate a map of ComplexData instances
generateData :: Int -> Map Int ComplexData
generateData count = fromList [(id, newComplexData id ("Item " ++ show id)) | id <- [1..count]]

-- Save data to a file
saveToFile :: FilePath -> Map Int ComplexData -> IO ()
saveToFile filename data = 
  writeFile filename (unlines (map formatData (toList data)))

-- Format data as a string
formatData :: (Int, ComplexData) -> String
formatData (_, ComplexData id name values) =
  printf "ID: %d, Name: %s, Average Value: %.2f" id name (calculate (ComplexData id name values))

-- Main function to simulate the processing and saving of data
main :: IO ()
main = do
  putStrLn "Processing data..."
  let data = generateData 10
  putStrLn "\nGenerated Data:"
  mapM_ (putStrLn . formatData) (toList data)

  saveToFile "data_output.txt" data
  putStrLn "\nData successfully saved to 'data_output.txt'."

  -- Simulate async-like behavior with a delay
  putStrLn "\nSimulating async-like behavior..."
  let delay = 1000 * 1000 -- 1 second in microseconds
  threadDelay delay
  putStrLn "Task completed!"
