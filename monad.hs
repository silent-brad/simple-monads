-- Writer, Option, Promise/Future, None, Result

square :: Int -> Int
square x = x * x

addOne :: Int -> Int
addOne x = x + 1

anotherFn :: Int -> String
anotherFn x = "The number is: " ++ show x

identity :: (Show a) => a -> String
identity x = "The value is: " ++ show x

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

wrapWithLogs :: a -> Result a
wrapWithLogs x = Result {
    value = x,
    logs = []
  }

runWithLogs :: Result a -> (a -> Result b) -> Result b
runWithLogs input transform =
  Result {
    value = (value newValue),
    logs = (logs input) ++ (logs newValue)
  }
    where newValue = transform (value input)

main :: IO ()
main = do
  print $ (logs (((addOneWithLogs 2) `runWithLogs` squareWithLogs) `runWithLogs` addOneWithLogs))
