square :: Int -> Int
square x = x * x

addOne :: Int -> Int
addOne x = x + 1

anotherFn :: Int -> String
anotherFn x = "The number is: " ++ show x

--identity :: (Show a) => a -> String
--identity x = "The value is: " ++ show x

data Result a = Result
  { value :: a
  , logs :: [String]
  }

squareWithLogs :: Int -> Result Int
squareWithLogs x = Result {
    value = square x,
    logs = ["Squared " ++ show x ++ " to get " ++ show (square x) ++ "."]
  }

addOneWithLogs :: Int -> Result Int
addOneWithLogs x = Result {
    value = addOne x,
    logs = ["Added 1 to " ++ show x ++ " to get " ++ show (addOne x) ++ "."]
  }

wrap :: a -> Result a
wrap x = Result {
    value = x,
    logs = []
  }

run :: Result a -> (a -> Result b) -> Result b
run input transform =
  Result {
    value = (value newValue),
    logs = (logs input) ++ (logs newValue)
  }
    where newValue = transform (value input)

main :: IO ()
main = do
  print $ (logs (((addOneWithLogs 2) `run` squareWithLogs) `run` addOneWithLogs))
