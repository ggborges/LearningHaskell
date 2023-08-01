parInt :: (Int, Int)
parInt = (22, 33)

minAndMax :: Integer -> Integer -> (Integer, Integer)
minAndMax x y
  | x >= y = (y, x)
  | otherwise = (x, y)

addPair :: (Integer, Integer) -> Integer
addPair (x, y) = x + y

addPair2 :: (Integer, Integer) -> Integer
addPair2 (0, y) = y
addPair2 (x, 0) = x
addPair2 (x, y) = x + y

shift :: ((Integer, Integer), Integer) -> (Integer, (Integer, Integer))
shift ((x, y), z) = (x, (y, z))

{-
Haskell possui duas funções de seleção sobre listas
fst (x, y) = x -- Functio first
snd (x, y) = y -- Function second
-}

addPair3 :: (Integer, Integer) -> Integer
addPair3 p = fst p + snd p -- p é uma lista/tupla

fibStep :: (Integer, Integer) -> (Integer, Integer)
fibStep (u, v) = (v, u + v)

fibTwoStep :: Integer -> Integer -> (Integer, Integer)
fibTwoStep u v = (v, u + v)

fibPair :: Integer -> (Integer, Integer)
fibPair n
  | n == 0 = (0, 1)
  | otherwise = fibStep (fibPair (n-1))

{-
fibPair 5
= fibStep (fibPair 4)
= fibStep (fibPair 4) >> fibStep (fibPair 3)
= fibStep (fibPair 4) >> fibStep (fibPair 3) >> fibStep (fibPair 2)
= fibStep (fibPair 4) >> fibStep (fibPair 3) >> fibStep (fibPair 2) >> fibStep (fibPair 1)
= fibStep (fibPair 4) >> fibStep (fibPair 3) >> fibStep (fibPair 2) >> fibStep (fibPair 1) >> fibStep (fibPair 0)
= fibStep (fibPair 4) >> fibStep (fibPair 3) >> fibStep (fibPair 2) >> fibStep (fibPair 1) >> fibStep (0,1)
= fibStep (fibPair 4) >> fibStep (fibPair 3) >> fibStep (fibPair 2) >> fibStep (1, 1)
= fibStep (fibPair 4) >> fibStep (fibPair 3) >> fibStep (fibPair 2) >> (1, 2)
= fibStep (fibPair 4) >> fibStep (fibPair 3) >> fibStep (1, 2)
= fibStep (fibPair 4) >> fibStep (fibPair 3) >> (2, 3)
= fibStep (fibPair 4) >> fibStep (2, 3)
= fibStep (fibPair 4) >> (3, 5)
= fibStep (3,5)
= (5, 8)
-}

fastFib :: Integer -> Integer
fastFib n = fst (fibPair n)

{-
. ax² + bx + c = 0
  . Duas raízes, se b² > 4.0*a*c (4ac)
  . Uma raiz, se b² = 4.0*a*c (4ac)
  . Não possui raízes, se (-b +-sqrt((b²-4ac)/2a)
-}

umaRaiz :: Float -> Float -> Float -> Float
umaRaiz a b c = (-b)/(2*a)

duasRaizes :: Float -> Float -> Float -> (Float, Float)
duasRaizes a b c = (d - e, d + e)
  where
    d = -b/(2*a)
    e = sqrt (b^2 - 4.0*a*c)/(2.0*a)

raizes :: Float -> Float -> Float -> String
raizes a b c
  | (b^2 == 4.0*a*c) = show (umaRaiz a b c)
  | (b^2 > 4.0*a*c) = show f ++ " " ++ show s
  | otherwise = "nao ha raizes"
  where
    (f, s) = duasRaizes a b c
  --f = fst (duasRaizes a b c)
  --s = snd (duasRaizes a b c)

{-
A palavra type introduz um sinônimo para um tipo. 
Onde o nome for utilizado, há o mesmo efeito do uso 
direto do tipo
-}

type Nome = String
type Idade = Int
type Phone = String
type Pessoa = (Nome, Idade, Phone)

-- Retorna o Nome de uma Pessoa
nome :: Pessoa -> Nome
nome (n, i, p) = n