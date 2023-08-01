-- Listas devem ser homogêneas (mesmo tipo)

-- $ > head [1,2,3,4,5]
-- > 1
-- $ > tail [1,2,3,4,5]
-- > [2,3,4,5]
-- $ > init [1,2,3,4,5]
-- > [1,2,3,4]
-- $ > last [1,2,3,4,5]
-- $ > 5

-- estudar map ; zip ; filter

{-
Funções de Listas Predefinidas:

Haskell possui diversas funções predefinidas para manipulação de listas, tais como head, tail, last, init, length, null, take, drop, reverse, elem, filter, map, entre outras.

null []
-- True

null [1,2,3,4]
-- False

Compreensão de Lista (List Comprehension):

A compreensão de lista é uma construção poderosa para criar novas listas a partir de listas existentes, aplicando transformações e/ou filtros.
Exemplo:
listaOriginal = [1, 2, 3, 4, 5]
listaQuadrados = [x^2 | x <- listaOriginal] -- Resultado: [1, 4, 9, 16, 25]


[ expressão | variável <- listaOriginal, condição ]

expressão: representa uma transformação ou cálculo a ser aplicado a cada elemento da lista original.
variável: é uma variável temporária que assume o valor de cada elemento da lista original.
listaOriginal: é a lista da qual queremos extrair os elementos para processamento.
condição (opcional): é uma expressão booleana que filtra os elementos da lista original que atendem a uma determinada condição.

Exemplos:
-}

quadrados :: [Int]
quadrados = [ x^2 | x <- [1..5]]

pares :: [Int]
pares = [ x | x <- [1..10] , x `mod` 2 == 0]

-- todas as combinações de pares de elementos das listas [1, 2, 3] e [4, 5]:

combinacoes1 :: [(Int, Int)]
combinacoes1 = [ (x,y) | x <- [1,2,3], y <- [4, 5]]

combinacoesPares :: [(Int, Int)]
combinacoesPares = [ (x,y) | x <- [1..9], y <- [10..18], (x `mod` 2 == 0) && (y `mod` 2 == 0)]

combinacoes :: Integer -> [a] -> [[a]]
combinacoes 0 _ = [[]]
combinacoes _ [] = []
combinacoes k (x:xs) = [ x : rest | rest <- combinacoes (k-1) xs] ++ combinacoes k xs

divisores :: Integer -> [Integer]
divisores n
    | n > 0 = [ x | x <- [1..n], n `mod` x == 0]
    | otherwise = []

isPrime :: Integer -> Bool
isPrime 1 = False
isPrime n = if (divisores n) == [1, n] then True else False

primos :: Integer -> [Integer]
primos n = [ x | x <- [1..n], isPrime x]