data Estacao = Inverno | Verao | Outono | Primavera
data Tempo = Quente | Frio
    deriving (Show)

clima :: Estacao -> Tempo
clima Inverno = Frio
clima _ = Quente

data DiasSemana = Dom | Seg | Ter | Qua | Qui | Sex | Sab
  deriving (Show, Eq, Enum, Ord, Read)


type Nome = String
type Idade = Int
data Pessoas = Pessoa Nome Idade

showPessoa :: Pessoas -> String
showPessoa (Pessoa n i) = "Nome: " ++ n ++ " | Idade: " ++ show i

type Preco = Int
data Produtos = Produto Nome Preco
  deriving (Show)

type PessoasTuplas = (Nome, Idade)

data Shape = Circle Float
            | Rectangle Float Float

isRound :: Shape -> Bool
isRound (Circle _) = True
isRound _ = False

area :: Shape -> Float
area (Circle r) = pi * r * r
area (Rectangle b h) =  b * h

data Expr = Lit Int
           | Add Expr Expr
           | Sub Expr Expr
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
            Node Integer Tree Tree

sumTree :: Tree -> Integer
sumTree NilT = 0
sumTree (Node n t1 t2) = n + sumTree t1 + sumTree t2

collapse :: Tree -> [Integer]
collapse NilT = []
collapse (Node n t1 t2) = collapse t1 ++ [n] ++ collapse t2

occurs :: Tree -> Integer -> Integer
occurs NilT _ = 0
occurs (Node n t1 t2) p
  | n == p = 1 + occurs t1 p + occurs t2 p
  | otherwise = occurs t1 p + occurs t2 p

-- Tipos algébricos polimorficos

data Pairs t = Pair t t

data List t = Nil | Cons t (List t)
  deriving (Show)

data TreeP t = NilTP |
               NodeP t (TreeP t) (TreeP t)

collapseP :: TreeP t -> [t]
collapseP NilTP = []
collapseP (NodeP n t1 t2) = collapseP t1 ++ [n] ++ collapseP t2

data MEither a b = MLeft a | MRight b
  deriving (Eq, Ord, Read, Show)

