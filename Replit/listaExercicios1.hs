-- 1a questão
-- Definir a função dobro de Integer -> Integer
-- Retornar o argumento multiplicado por 2.

funcDobro :: Integer -> Integer
funcDobro x = 2 * x

-- 2a questão
-- Definir função quadruplo
-- Utilizando a funcDobro para retornar o argumento
-- multiplicado por 4

funcQuadruplo :: Integer -> Integer
funcQuadruplo x = funcDobro (funcDobro x)

-- 3a questão
-- Definir a função poli2. Quatro argumentos do tipo Double e retorna a*x² + b*x + c

poli2 :: Double -> Double -> Double -> Double -> Double
poli2 a b c x = (a * (x^2)) + (b * x) + c

-- 4a questao
-- Definir função parImpar que devolve “par” (string) para entradas par e “impar” (string) para entradas impar.

ehImpar :: Int -> Bool
ehImpar n
  | n <= 0 = False
  | otherwise = ehPar (n-1)

ehPar :: Int -> Bool
ehPar n
  | n < 0 = False
  | n == 0 = True
  | otherwise = ehImpar (n-1)

ehPar' :: Int -> Bool
ehPar' x
  | x == 0 = True
  | (x `mod` 2) == 0 = True
  | x < 2 && x > 0 = False
  | otherwise = ehPar' (x `mod` 2)

parImpar :: Int -> String
parImpar x = if ehPar' x then "Eh Par!" 
              else "Eh Impar!" 

-- 5a questão
-- Três definições para função maxFour :: Int -> Int -> Int -> Int -> Int (uma usando maxThree, outra usando max e outra usando maxThree e max)

max' :: Int -> Int -> Int
max' x y
 | x >= y = x
 | otherwise = y

--maxi' :: Integer -> Integer -> Integer
--maxi' x y = if x >= y then x else y

maxThree :: Int -> Int -> Int -> Int
maxThree x y z
 | x >= y && x >= z = x
 | y >= z = y
 | otherwise = z

-- Usando maxThree
maxFour1 :: Int -> Int -> Int -> Int -> Int
maxFour1 a b c d
  | (maxThree a b c) > d = (maxThree a b c)
  | otherwise = d

-- Usando max
maxFour2 :: Int -> Int -> Int -> Int -> Int
maxFour2 a b c d
  | (max' a b) > (max' c d) = max' a b
  | otherwise = max' c d

-- Usando max e maxThree
maxFour3 :: Int -> Int -> Int -> Int -> Int
maxFour3 a b c d = maxThree a b (max' c d)

-- 6a questão
-- Defina a função quantosIguais que retorna quantos dos três argumentos são iguais

quantosIguais :: Integer -> Integer -> Integer -> Integer
quantosIguais x y z
  | (x == y) && (x == z) = 3
  | (x == y) || (y == z) || (x == z) = 2
  | otherwise = 0

-- 8a questão
-- Usando recursão, implemente a função sumTo, de modo que sumTo n calcula o valor de 1 + 2 + ...+ n

sumTo :: Integer -> Integer
sumTo n
  | n == 1 = 1
  | otherwise = sumTo (n-1) + n

-- 9a questão
-- Defina a função potencia, de modo que potencia n k calcula n elevado a k. Use recursão.

potencia :: Integer -> Integer -> Integer
potencia n k
  | k == 1 = n
  | otherwise = potencia n (k-1) * n

-- 10a questão
-- Usando recursão, compute os coeficientes binomiais dados pelas seguintes equações
--B(n, k) = B(n − 1, k) + B(n − 1, k − 1)
--B(n, 0) = 1
--B(0, k) = 0, quando k > 0
--Dica: usar casamento de padrão pode ser de grande ajuda.

binomial :: Integer -> Integer -> Integer
binomial n 0 = 1
binomial 0 k = 1
binomial n k = binomial (n-1) k + binomial (n-1) (k-1)

{-

binomial :: Integer -> Integer -> Integer
binomial n 0 = 1
binomial n k
  | (n==0) && (k>0) = 1
  | otherwise = binomial (n - 1) k + binomial (n - 1) (k - 1)

-}

{-  11ª questão
    Os números de Tribonacci são dados pelas seguintes equações:
    -> T(1) = 1
    -> T(2) = 1
    -> T(3) = 2
    -> T(n + 1) = T(n) + T(n − 1) + T(n − 2)

_o> Implemente uma função recursiva eficiente que calcula T n. Considere o uso de uma
função auxiliar.
-}

trib :: Integer -> Integer
trib 1 = 1
trib 2 = 1
trib 3 = 2
trib n = trib (n-1) + trib (n-1) + trib (n-2)

{-  12ª questão
    Defina a função addEspacos que produz um string com uma quantidade n de espaços.
o> addEspacos :: Int −> String
-}

addEspacos :: Int -> String
addEspacos n
  | n == 1 = " "
  | otherwise = addEspacos (n-1) ++ " "

{-  13ª questão
    Defina a função paraDireita utilizando a definição de addEspacos para adiciconar uma
quantidade n de espaços à esquerda de um dado String, movendo o mesmo para a direita.
paraDireita :: Int −> String −> String
-}

paraDireita :: Int -> String -> String
paraDireita n s
  | n == 1 = "_"
  | otherwise =  paraDireita (n-1) "" ++ "_" ++ s

-- Utilizando a função addEspacos

paraDireita' :: Int -> String -> String
paraDireita' n s = addEspacos n ++ s

{-  14ª questão
Escreva uma função para retornar, em forma de tabela, todas as vendas da semana 0 até a semana n, incluindo o total e a média de vendas no período. Usem as funções definidas previamente e defina novas funções que achar necessário.
Semana Venda
   0     12
   1     14
   2     15
 Total = 41
 Média = 13.6667

imprimeTabela :: Int −> String
imprimeTabela n = cabecalho
++ imprimeSemanas n
++ imprimeTotal n
++ imprimeMedia n
-}

semanas :: Int -> String
semanas n
  | n == 0 = addEspacos 2 ++ "0" ++ addEspacos 5 ++ "12" ++ "\n"
  | n == 1 = semanas (n-1) ++ addEspacos 2 ++ "1" ++ addEspacos 5 ++ "14\n"
  | n == 2 = semanas (n-1) ++ addEspacos 2 ++ "2" ++ addEspacos 5 ++ "15\n"

total :: Int -> Int
total n
  | n == 0 = 12
  | n == 1 = total (n-1) + 14
  | n == 2 = total (n-1) + 15

media :: Int -> String
media n
  | n == 0 = "12"
  | n == 1 = show ((total n) `div` (n+1))
  | n == 2 = show ((total n) `div` (n+1))

imprimeTabela :: Int -> String
imprimeTabela n = "Semana" ++ addEspacos 1 ++ "Venda\n" ++ semanas n ++ addEspacos 1 ++ "Total" ++ addEspacos 2 ++ show (total n) ++ "\n Media" ++ addEspacos 2 ++ media n ++ "\n"
  