
square :: Int -> Int
square x = x * x

addOne :: Int -> Int
addOne x = x + 1

data NumberWithLogs = NumberWithLogs
  { result :: Int
  , logs :: [String]
  }

squareWithLogs :: Int -> NumberWithLogs
squareWithLogs x = NumberWithLogs {
    result = square x,
    logs = ["Squared " ++ show x ++ " to get " ++ show (square x) ++ "."]
  }

addOneWithLogs :: Int -> NumberWithLogs
addOneWithLogs x = NumberWithLogs {
    result = addOne x,
    logs = ["Added 1 to " ++ show x ++ " to get " ++ show (addOne x) ++ "."]
  }

wrapWithLogs :: Int -> NumberWithLogs
wrapWithLogs x = NumberWithLogs {
    result = x,
    logs = []
  }

runWithLogs :: NumberWithLogs -> (Int -> NumberWithLogs) -> NumberWithLogs
runWithLogs input transform =
  NumberWithLogs {
    result = (result newNum),
    logs = (logs input) ++ (logs newNum)
  }
    where newNum = transform (result input)

main :: IO ()
main = do
  print $ (logs (((addOneWithLogs 2) `runWithLogs` squareWithLogs) `runWithLogs` addOneWithLogs))
