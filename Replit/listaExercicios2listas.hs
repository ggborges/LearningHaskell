{-  1ª questão

Defina a função

paraMaiuscula :: String −> String

que transforma toda letra minúscula em uma string em maiúscula. Use compreensão de listas.

  Modifique esta função para se comportar da mesma forma, mas removendo todos os caracteres que não são letras da string resultante.
-}

offset = fromEnum('A') - fromEnum('a')

maiuscula :: Char -> Char
maiuscula ch = toEnum(fromEnum ch + offset)

minuscula :: Char -> Char
minuscula ch = toEnum(fromEnum ch - offset)

ehDigito :: Char -> Bool
ehDigito ch = ('0' <= ch) && (ch <= '9')

paraMaiuscula :: String -> String
paraMaiuscula s = [toEnum (fromEnum (c)+offset) | c <- s]

maiusculaSohLetras :: String -> String
maiusculaSohLetras s = [toEnum (fromEnum (c) + offset) | c <- s , ( (fromEnum c >= 65 && fromEnum c <= 90) || (fromEnum c >= 97 && fromEnum c <= 122) )]

{-  2ª questão

Defina a função

divisores :: Integer −> [Integer]

que retorna uma lista de divisores e um inteiro positivo e uma lista vazia para outras entradas

Use divisores para definir a função

isPrime :: Integer −> Bool

que testa se um número é primo.
-}

divisores :: Integer -> [Integer]
divisores x = [ n | n <- [1..x] , x `rem` n == 0]

isPrime :: Integer -> Bool
isPrime x
  | divisores x == [1, x] = True
  | otherwise = False

{- 3ª questão

  Dada uma lista de inteiros, defina a função menorLista que encontra o menor inteiro dessa lista
-}

menorLista :: [Integer] -> Integer
menorLista (x:xs)
  | length xs == 0 = x
  | x <= head xs = menorLista (x : (drop 1 xs))
  | otherwise = menorLista xs

{- 4ª questão

Defina a função

fibTable :: Integer −> String

que produz uma tabela com os números de Fibonacci. A saída para fibTable 6 é

n   fib n
0   0
1   1
2   1
3   2
4   3
-}

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

--fibTable :: Integer -> String
--fibTable n = show ([x | x <- fastFib n])

{- 5ª questão

Defina função measure que, para um lista vazia, retorna -1 e ,para outras listas, retorna o tamanho da lista
-}

measure :: [a] -> Int
measure [] = -1
measure (x:xs) = measure xs + 1

{- 6ª questão

Defina a função takeFinal que retorna os últimos n elementos de uma lista dada como argumento
-}

takeFinal :: [a] -> Int -> [a]
takeFinal (x:xs) n
  | length (x:xs) == n = (x:xs)
  | otherwise = takeFinal xs n

{- 7ª questão

Defina uma função que remove o enésimo elemento de uma lista, ou seja, retorna uma lista que idêntica à lista recebida como argumento, com exceção de que o enésimo não consta na lista de retorno. A indexação começa em zero. Exemplos:

remove 0 [ 1 , 2 , 3 ] ==> [ 2 , 3 ]
remove 2 [ 4 , 5 , 6 , 7 ] ==> [ 4 , 5 , 7 ]
-}

remove :: Int -> [a] -> [a]
remove 0 (x:xs) = xs
remove n (x:xs) = [ y | y <- (x:xs) , (y /= ((x:xs)!!n))]