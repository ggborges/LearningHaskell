parseInput str = let [n, k] = map read (words str)
                 in (n, k)
main :: IO()
main = interact $ show . uncurry potencia . parseInput

potencia :: Integer -> Integer -> Integer
potencia n k
  | k == 1 = n
  | otherwise = potencia n ((k-1) * n)


remDiv :: Int -> [a] -> ([a],[a])
remDiv n (x:xs)
  | length (x:xs) == n = (x:xs)
  | otherwise = takeFinal n xs

remove :: Int -> [a] -> [a]
remove 0 (x:xs) = xs
remove n (x:xs) = [ y | y <- (x:xs) , (y /= ((x:xs)!!n))]

remDiv :: Int -> [a] -> ([a],[a])
remDiv 0 (x:xs) = ([],(x:xs))
remDiv n (x:xs)
  | 
  | otherwise = ([y | y <- ], [w | w <- ])
