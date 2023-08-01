-- 1.

dobro :: Integer -> Integer
dobro x = 2 * x

-- 2.

quadruplo :: Integer -> Integer
quadruplo x = dobro x * 2

-- 3.

poli2 :: Double -> Double -> Double -> Double -> Double
poli2 a b c x = a * (x^2) + b * x + c

-- 4.

parImpar :: Integer -> String
parImpar x = if ehPar x then "Par" else "Impar"
  where
    ehPar :: Integer -> Bool
    ehPar y
      | y < 0 = False
      | y == 0 = True
      | otherwise = ehImpar(y-1)
    ehImpar :: Integer -> Bool
    ehImpar n
      | n <= 0 = False
      | otherwise = ehPar(n-1)

-- 5.

maxFour3 :: Integer -> Integer -> Integer -> Integer -> Integer
maxFour3 a b c d = let maior = maxThree a b c
                  in if maior > d then maior else d

maxFourMax :: Integer -> Integer -> Integer -> Integer -> Integer
maxFourMax a b c d = let maiorEsq = max' a b
                         maiorDir = max' c d
                     in if maiorEsq > maiorDir then maiorEsq else maiorDir

maxFourMax2 :: Integer -> Integer -> Integer -> Integer -> Integer
maxFourMax2 a b c d = max(max a b) (max c d)

maxFourMax3 :: Integer -> Integer -> Integer -> Integer -> Integer
maxFourMax3 a b c d = maxThree a b (max' c d)

maxThree2 :: Integer -> Integer -> Integer -> Integer
maxThree2 a b c = max a (max b c)

maxThree :: Integer -> Integer -> Integer -> Integer
maxThree m n p
  | (m >= n) && (m >= p) = m
  | (n >= p) = n
  | otherwise = p

max' :: Integer -> Integer -> Integer
max' x y = if x > y then x else y

-- 6.

quantosIguais :: Integer -> Integer -> Integer -> Integer
quantosIguais x y z
  | x == y && y == z = 3
  | y == z = 2
  | x == z = 2
  | otherwise = 0

  -- 7.

ehZero :: Integer -> Bool
ehZero 0 = True
ehZero _ = False

  -- 8.

sumTo :: Integer -> Integer
sumTo 1 = 1
sumTo n = sumTo (n-1) + n

  -- 9.

potencia :: Integer -> Integer -> Integer
potencia n 1 = n
potencia n k = potencia n (k-1) * n

 -- 10.

binomial :: Integer -> Integer -> Integer
binomial _ 0 = 1
binomial 0 _ = 0
binomial n k = binomial (n-1) k + binomial (n-1) (k-1)

{-
binomial n k
    | k == 0    = 1
    | n == 0    = 0
    | otherwise = binomial (n - 1) k + binomial (n - 1) (k - 1)
-}

{-
    binomial 4 5
  = binomial 3 5 + binomial 3 4
  = binomial 2 5 + binomial 2 4 + binomial 3 4
  = binomial 1 5 + binomial 1 4 + binomial 2 4 + binomial 3 4
  = binomial 0 5 + binomial 0 4 + binomial 1 4 + binomial 2 4 + binomial 3 4
  = 0 + 0 + binomial 1 4 + binomial 2 4 + binomial 3 4
  = 0 + binomial 0 4 + binomial 0 3 + binomial 2 4 + binomial 3 4
  = 0 + 0 + 0 + binomial 2 4 + binomial 3 4
  = 0 + binomial 1 4 + binomial 1 3 + binomial 3 4
  = 0 + binomial 3 4
  = 0 + binomial 2 4 + binomial 2 3

-}

  -- 11.

tribonacci :: Integer -> Integer
tribonacci 1 = 1
tribonacci 2 = 1
tribonacci 3 = 2
tribonacci n = tailTrib n 0

tailTrib :: Integer -> Integer -> Integer
tailTrib 0 x = x
tailTrib n x = let summ = (n-1) + (n-2) + (n-3)
               in tailTrib (n - 1) (summ + x)


trib' :: Integer -> Integer
trib' 1 = 1
trib' 2 = 1
trib' 3 = 2
trib' n = trib' (n-1) + trib' (n-2) + trib' (n-3)
