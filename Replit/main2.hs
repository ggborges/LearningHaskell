square :: Integer -> Integer
square x = x^2

addD :: Integer -> Integer -> Integer
addD x y = 2 * (x + y)

sumDoubleSquare :: Integer -> Integer -> Integer
sumDoubleSquare x y = (2 * (x^2)) + (2 * (y * y))

sumDoubleSquare2 :: Integer -> Integer -> Integer
sumDoubleSquare2 x y = sDsX + sDsY
  where sDsX = 2 * (x * x)
        sDsY = 2 * (y * y)

sumDoubleSquare3 :: Integer -> Integer -> Integer
sumDoubleSquare3 x y = sDs x + sDs y
  where sDs m = 2 * (m * m)

sumDoubleSquareF :: Integer -> Integer -> Integer
sumDoubleSquareF x y = sDs x + sDs y + f
  where sDs m = 2 * (m * m)
        f = 6

sumSquares :: Integer -> Integer -> Integer
sumSquares x y =  let sSx = x * x
                      sSy = y * y
                  in sSx + sSy

sumSquares2 :: Integer -> Integer -> Integer
sumSquares2 x y =  
      let sS m = m * m
      in sS x + sS y


maxsq :: Integer -> Integer -> Integer
maxsq x y
  | sqx > sqy = sqx
  | otherwise = sqy
  where
    sqx = sq x
    sqy = sq y
    sq :: Integer -> Integer
    sq z = z * z -- variável z está visível apenas na linha 42, não sendo visível pelo resto da função

maxsq' :: Integer -> Integer -> Integer
maxsq' x y
  | sq x > sq y = sq x
  | otherwise = sq y
  where
  sq x = x * x

{-
Define a function
onThreeLines :: String -> String -> String -> String
which takes three strings and returns a single string which when printed shows
the three strings on separate lines.
-}

onThreeLines :: String -> String -> String -> String
onThreeLines s1 s2 s3 = s1 ++ '\n' ++ s2 ++ '\n' ++ s3  