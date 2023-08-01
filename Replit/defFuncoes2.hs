-- Funções Recursivas:
-- Semana 2

-- Definir caso base, isto é, valor para fun 0 ou fun 1
-- Definir valor para fun n, usando o valor de fun (n-1)
-- este é o caso recursivo

fat :: Integer -> Integer
fat n
  | n == 0 = 1 -- Caso base
  | n > 0 = fat(n-1) * n -- Caso recursivo

fib :: Integer -> Integer
fib n
  | n == 0 = 0 -- Caso base
  | n == 1 = 1 -- Caso base
  | n > 1 = fib(n-2) + fib(n-1) -- Caso recursivo

fibStep :: (Integer, Integer) -> (Integer, Integer)
fibStep (u, v) = (v, u + v)

fibTwoStep :: Integer -> Integer -> (Integer, Integer)
fibTwoStep u v = (v, u + v)

fibPair :: Integer -> (Integer, Integer)
fibPair n
  | n == 0 = (0, 1)
  | otherwise = fibStep (fibPair (n-1))

fastFib :: Integer -> Integer
fastFib n = fst (fibPair n)


-- Casos de terminação não assegurada:
resto :: Integer -> Integer -> Integer
resto m n
  | m < n = m -- Caso base
  | otherwise = resto (m-n) n -- Caso recursivo
-- Caso resto 7 0 -> teremos um loop e não terminamos a função recursiva

divide :: Integer -> Integer -> Integer
divide m n
  | m < n = 0 -- Caso base
  | otherwise = 1 + divide (m-n) n -- Caso recursivo
-- Caso divide 4 (-4)

-- Recursão mútua
-- Na definição de uma função A apresentar uma chamada
-- para da função B e na definição da função B
-- ter uma chamada para a função A
ehImpar :: Int -> Bool
ehImpar n
  | n <= 0 = False
  | otherwise = ehPar (n-1)

ehPar :: Int -> Bool
ehPar n
  | n < 0 = False
  | n == 0 = True
  | otherwise = ehImpar (n-1)

-- Chamadas de cauda
--  _Tornam desnecessário que seja empilhado um stack
--frame por chamada
--  _Evitam estouro de pilha
--  _O GHC transforma diversas chamadas "comuns" em
--chamadas de cauda

tailFat :: Int -> Int -> Int
tailFat 0 x = x
tailFat n x = tailFat (n-1) (n*x)

fat' :: Int -> Int
fat' n = tailFat n 1


{-
Campo
  de
Texto
-}