    --                              Tipos Algébricos para definições de enumeração

busca :: Eq a => a -> [a] -> Maybe a
busca _ [] = Nothing
busca x (y:ys) = if x == y then Just x else busca x ys

safeDiv :: Int -> Int -> Either String Int
safeDiv _ 0 = Left "Divisão por zero não é permitida!"
safeDiv x y = Right (x `div` y)

{- Maybe
data Maybe a = Nothing | Just a

O tipo Maybe a é um tipo polimórfico que pode ser instanciado para qualquer tipo a. Ele possui dois construtores de dados:

Nothing: Representa a ausência de valor ou um valor inválido. É como se fosse um "nada" ou "vazio".
Just a: Representa um valor válido do tipo a que está presente. O valor é embrulhado dentro do construtor Just.
-}

{- Either
data Either a b = Left a | Right b

Em Haskell, Either é outro tipo de dados parametrizado que é usado para representar resultados que podem ser de dois tipos diferentes: um sucesso (Right) ou um erro (Left). É uma maneira de lidar com funções que podem retornar um valor ou uma mensagem de erro, de forma mais explícita e segura.

A definição do tipo Either é a seguinte:
-}

data Estacao = Inverno | Verao | Outono | Primavera

data Temp = Frio | Quente
        deriving (Show)

clima :: Estacao -> Temp
clima Inverno = Frio
clima _       = Quente

data DiasSemana = Dom | Seg | Ter | Qua | Qui | Sex
                deriving (Eq, Ord, Show, Read, Enum)

type Nome = String -- tipos sinônimos
type Idade = Int
data Pessoas = Pessoa Nome Idade -- 'Pessoa' é construtor para o tipo algébrico "Pessoas"

showPessoa :: Pessoas -> String
showPessoa (Pessoa n i) = n ++ " " ++ show i

type Preco = Int
data Produto = Produto Nome Preco
    deriving (Show)

data Shape = Circulo Float |
             Retangulo Float Float
            deriving (Show)

isRound :: Shape -> Bool
isRound (Circulo _) = True
isRound (Retangulo _ _) = False

area :: Shape -> Float
area (Circulo r) = pi * r * r
area (Retangulo b h) = b * h

mapShape :: [Float] -> [Shape]
mapShape xs = map (\x -> Circulo x) xs

    --                              Tipos algébricos para definição de tipos recursivos

data Expr = Lit Int       |
            Add Expr Expr |
            Sub Expr Expr
            deriving (Show)

eval :: Expr -> Int
eval (Lit n) = n
eval (Add e1 e2) = (eval e1) + (eval e2)
eval (Sub e1 e2) = (eval e1) - (eval e2)

mShow :: Expr -> String
mShow (Lit n) = show n
mShow (Add e1 e2) = "(" ++ mShow e1 ++ " + " ++ mShow e2 ++ ")"
mShow (Sub e1 e2) = "(" ++ mShow e1 ++ " - " ++ mShow e2 ++ ")"

data Tree = NilT |
            Node Int Tree Tree
            deriving (Show)

sumTree :: Tree -> Int
sumTree NilT = 0
sumTree (Node n no1 no2) = n + sumTree no1 + sumTree no2

collapse :: Tree -> [Int]
collapse (NilT) = []
collapse (Node n t1 t2) = collapse t1 ++ [n] ++ collapse t2

occurs :: Tree -> Int -> Int
occurs NilT p = 0
occurs (Node n t1 t2) p
    | n == p    = 1 + occurs t1 p + occurs t2 p
    | otherwise =     occurs t1 p + occurs t2 p

arvore = (Node 5 (Node 4 (Node 2 (NilT) (Node 1 (NilT) (NilT))) (Node 5 (NilT) (NilT))) (Node 1 (Node 8 (NilT) (NilT)) (Node 1 (Node 3 (NilT) (NilT)) (NilT))))

    --                              Tipos algébricos polimórficos

data Pairs t = Pair t t
            deriving (Eq, Ord)

data List t = Nil |
            Cons t (List t)
            deriving (Show)

data TreePoli t = NilTP |                               -- Tipo recursivo e polimórfico
                  NodeP t (TreePoli t) (TreePoli t)

collapsePoli :: TreePoli t -> [t]
collapsePoli (NilTP) = []
collapsePoli (NodeP n t1 t2) = collapsePoli t1 ++ [n] ++ collapsePoli t2

data MEither a b = MLeft a | MRight b
    deriving (Eq, Ord, Read, Show)

{-
createPairs :: Int -> IO ()
createPairs 0 = putStr ("Pares criados com sucesso!")
createPairs n = 
-}

main :: IO ()
main = do
        let pair = Pair 2 3
            pair2 = Pair 2 3

        putStrLn (show (pair == pair2))