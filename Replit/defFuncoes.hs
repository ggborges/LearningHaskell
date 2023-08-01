quadrado :: Integer -> Integer
quadrado x = x * x

addD :: Integer -> Integer -> Integer
addD x y = 2 * (x + y)

somaDobroQuadrado :: Integer -> Integer -> Integer
somaDobroQuadrado x y = (2 * (x * x)) + (2 * (y * y))

somaDobroQuadrado2 :: Integer -> Integer -> Integer
somaDobroQuadrado2 x y = dqX + dqY
  where
    dqX = 2 * (x * x)
    dqY = 2 * (y * y)

somaDobroQuadrado3 :: Integer -> Integer -> Integer
somaDobroQuadrado3 x y = dq x + dq y
  where
    dq n = 2 * (n * n)

somaDobroQuadradoLetIn :: Integer -> Integer -> Integer
somaDobroQuadradoLetIn x y =
    let dqX = 2 * (x * x)
        dqY = 2 * (y * y)
    in dqX + dqY

max' :: Integer -> Integer -> Integer
max' x y
 | sqX > sqY = sqX
 | otherwise = sqY
 where
 sqX = sq x
 sqY = sq y
 sq :: Integer -> Integer
 sq z = z * z

maxsq :: Integer -> Integer -> Integer
maxsq x y =
 | sq x > sq y = sq x
 | otherwise = sq y
 where
 sq x = x * x

fat :: Integer -> Integer
fat n =
 | n == 0 = 1 -- Caso base
 | n > 0 = fat(n-1) * n -- Caso recursivo

fib :: Integer -> Integer
fib n =
 | n == 0 = 0
 | n == 1 = 1
 | n > 1 = fib(n-2) + fib(n-1)
