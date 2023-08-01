-- 3.9

threeDifferent :: Integer -> Integer -> Integer -> Bool
threeDifferent m n p
  | (m == n) || (m == p) = False
  | (n == p) = False
  | otherwise = True

threeDifferentz :: Integer -> Integer -> Integer -> Bool
threeDifferentz m n p = not((m == n) || (n == p) || (m == p))

-- 3.10

fourEqual :: Integer -> Integer -> Integer -> Integer -> Bool
fourEqual m n p q
  | (m /= n) || (n /= p) || (p /= q) = False
  | (n /= p) || (n /= q) = False
  | (p /= q) = False
  | otherwise = True

fourEqualx :: Integer -> Integer -> Integer -> Integer -> Bool
fourEqualx m n p q = (m == n) && (n == p) && (p == q)

-- using threeEqual
threeEqual :: Integer -> Integer -> Integer -> Bool
threeEqual m n p = (m == n) && (n == p)

fourEquals :: Integer -> Integer -> Integer -> Integer -> Bool
fourEquals m n p q = (m == n) && threeEqual n p q

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
