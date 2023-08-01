import Data.Char

    -- 1. 

paraMaiuscula :: String -> String
paraMaiuscula = map toUpper

maiuscula :: Char -> Char
maiuscula ch
    | ord ch > 96 = chr ((ord ch) - 32)
    | otherwise   = ch


paraMaiuscula1 :: String -> String
paraMaiuscula1 = map maiuscula

paraMaiuscula2 :: [Char] -> [Char]
paraMaiuscula2 [] = []
paraMaiuscula2 (x:xs) = maiuscula x : paraMaiuscula2 xs


paraMaiuscula3 :: [Char] -> [Char]
paraMaiuscula3 str = [ maiuscula ch | ch <- str]

paraMaiuscula4 :: [Char] -> [Char]
paraMaiuscula4 str = [if ord ch > 96 then chr ((ord ch) - 32) else ch | ch <- str]

paraMaiuscula5 :: [Char] -> [Char]
paraMaiuscula5 [] = []
paraMaiuscula5 (x:xs)
    | ord x > 96 = chr (ord x - 32):[] ++ paraMaiuscula5 xs
    | otherwise = x:[] ++ paraMaiuscula5 xs


removeNonUpperCase :: [Char] -> [Char]
removeNonUpperCase str = [ ch | ch <- str, ch `elem` ['A'..'Z']]

removeNonUpperCase2 :: [Char] -> [Char]
removeNonUpperCase2 str = [ ch | ch <- str, ord ch > 96]

    -- 2.

divisores :: Int -> [Int]
divisores n
    | n > 0 = [ x | x <- [1..n], n `mod` x == 0]
    | otherwise = []

isPrime :: Int -> Bool
isPrime 1 = False
isPrime n = if (divisores n) == [1, n] then True else False

primos :: Int -> [Int]
primos n = [ x | x <- [1..n], isPrime x]

{-
    Solução gabarito:

divide :: Int -> Int -> Bool
divide n k
    | n `mod` k == 0 = True
    | otherwise = False

divisores :: Int -> [Int]
divisores 0 = []
divisores n = [i | i <- [1..n], divide n i]

isPrime :: Int -> Bool
isPrime 1 = False
isPrime n
    | length (divisores n) == 2 = True
    | otherwise = False
-}

    -- 3.

menorLista :: [Int] -> Int
menorLista [x] = x
menorLista (x:xs) = min x (menorLista xs)

    -- 4.

cabecalho = "n\tfib n\n"

printLinha :: Int -> String
printLinha 0 = concat[(show 0) ++ "\t" ++ (show (fastFib 0)) ++ "\n"]
printLinha n = concat[printLinha (n-1) ++ (show n) ++ "\t" ++ (show (fastFib n)) ++ "\n"]

fibTabela :: Int -> String
fibTabela 1 = cabecalho
fibTabela n = cabecalho
              ++ printLinha (n-2)

fibStep :: (Int, Int) -> (Int, Int)
fibStep (u, v) = (v, u + v)

fibPair :: Int -> (Int, Int)
fibPair n
  | n == 0 = (0, 1)
  | otherwise = fibStep (fibPair (n-1))

fastFib :: Int -> Int
fastFib n = fst (fibPair n)

    -- 5.

measure :: [a] -> Int
measure [] = -1
measure [_] = 1
measure (_:xs) = measure xs + 1

    -- 6.

takeFinal :: Int -> [a] -> [a]
takeFinal _ [] = []
takeFinal 0 _ = []
takeFinal 1 [a] = [a]
takeFinal n (x:xs) = if (measure (x:xs)) == n then (x:xs) else takeFinal n xs

    -- 7.

remove :: Int -> [Int] -> [Int]
remove 0 lista = lista
remove n lista
    | n < 0 = lista
    | n > (measure lista) - 1 = lista
    | otherwise = [ x | x <- lista, (x /= (lista !! n)) ]

--  #####    Resolução do gabarito
removeAt :: Int -> [a] -> [a] -- O argumento Int para a função removeAt é o index do array (index 3 é o quarto elemento)
removeAt _ [] = []
removeAt 0 (x:xs) = xs
removeAt i arr = take i arr ++ drop (i + 1) arr -- No take e drop, o i é a posição, ou seja (i = 3 é o index 2)


    -- 8.

firstInteger :: [Int] -> Int
firstInteger [] = 0
firstInteger (x:_) = x + 1

firstInteger2 :: [Int] -> Int
firstInteger2 [] = 0
firstInteger2 lista = head lista

    -- 9.

add2 :: [Int] -> Int
add2 [] = 0
add2 [x] = x
add2 (x:y:xs) = x + y
--add2 (x:xs) = x + head xs

add2' :: [Int] -> Int
add2' lista
    | length lista == 0 = 0
    | length lista == 1 = head lista
    | otherwise         = head lista + (head (tail lista))

    -- 10.

produto :: [Int] -> Int
produto [] = 1
produto (x:xs) = x * produto xs

    -- 11.

-- Solução ChatGPT  xxx_ERRADA_xxx

unique :: [Int] -> [Int]
unique []     = []
unique (x:xs)
    | (countOccurrence x xs) == 0 = x : unique xs -- se não há ocorrência na cauda (xs) da lista de entrada, retorna x e chamada unique xs (na ultima chamada da lista vazia = x : [])
    | otherwise = unique (filter (/= x) xs) -- se não é elemento único, o filter retira da lista (/= x)

countOccurrence :: Int -> [Int] -> Int
countOccurrence _ []     = 0
countOccurrence x (y:ys)
    | x == y    = 1 + countOccurrence x ys -- compara o elemento 'x' com o primeiro elemento 'y' (recursão com a cauda se for igual)
    | otherwise = countOccurrence x ys

-- Solução gabarito

elementIn :: Int -> [Int] -> Bool
elementIn _ [] = False
elementIn elem (x:xs)
    | x == elem = True
    | otherwise = elementIn elem xs

unique' :: [Int] -> [Int]
unique' [] = []
unique' (x:xs)
    | elementIn x xs = unique' xs -- se tem ocorrência de 'x' em 'xs', então ignora x
    | otherwise      = x : unique' xs

    -- 12.

isCrescent :: [Int] -> Bool
isCrescent []     = True
isCrescent [x,y]  = y > x
isCrescent (x:xs)
    | x <= (head xs) = True && isCrescent xs
    | otherwise      = False

    -- Solução do gabarito

smallarity :: Int -> [Int] -> Bool
smallarity _ [] = True
smallarity elem [x]
    | x >= elem = True
    | otherwise = False
smallarity elem (x:xs)
    | x >= elem = smallarity elem xs
    | otherwise = False

checkOrder :: [Int] -> Bool
checkOrder []  = True
checkOrder [x] = True
checkOrder (x:xs)
    | smallarity x xs = checkOrder xs
    | otherwise       = False

main :: IO ()
main = do
    putStrLn (fibTabela 3)


-------------------------       Exercícios 5.6 do livro

    --              5.18

doubleAll :: [Integer] -> [Integer]
doubleAll xs = [2*x | x <- xs]