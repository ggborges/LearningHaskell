eXor :: Bool -> Bool -> Bool
eXor x y = (x || y) && not (x && y)

mNot :: Bool -> Bool
mNot True = False
mNot False = True

eXor' :: Bool -> Bool -> Bool
eXor' True x = mNot x
eXor' False x = x

tresIguais :: Integer -> Integer -> Integer -> Bool
tresIguais m n p = (m == n) && (n == p)

offset = fromEnum('A') - fromEnum('a')

maiuscula :: Char -> Char
maiuscula ch = toEnum(fromEnum ch + offset)

minuscula :: Char -> Char
minuscula ch = toEnum(fromEnum ch - offset)

ehDigito :: Char -> Bool
ehDigito ch = ('0' <= ch) && (ch <= '9')

maxi :: Integer -> Integer -> Integer
maxi x y
 | x >= y = x
 | otherwise = y

maxi' :: Integer -> Integer -> Integer
maxi' x y = if x >= y then x else y

max3 :: Integer -> Integer -> Integer -> Integer
max3 x y z
 | x >= y && x >= z = x
 | y >= z = y
 | otherwise = z

min :: Integer -> Integer -> Integer
min x y = if x <= y then x else y

-- Usando guardas

min' :: Integer -> Integer -> Integer
min' x y
 | x <= y = x
 | otherwise = y

minThree :: Integer -> Integer -> Integer -> Integer
minThree x y z
 | x <= y && x <= z = x
 | y <= z = y
 | otherwise = z

