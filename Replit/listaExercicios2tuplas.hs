{- 1ª questão
Defina a função menorMaior que recebe três inteiros e retorna uma tupla com o menor e o maior deles, respectivamente.
-}

maior :: Int -> Int -> Int -> Int
maior x y z
  | x >= y && y >= z = x
  | y >= z = y
  | otherwise = z

menor :: Int -> Int -> Int -> Int
menor x y z
  | x <= y && x <= z = x
  | y <= z = y
  | otherwise = z

menorMaior :: Int -> Int -> Int -> (Int, Int)
menorMaior x y z = ((menor x y z), (maior x y z))

menorMaior' :: Int -> Int -> Int -> (Int, Int)
menorMaior' x y z = ((menori x y z), (maiori x y z))
  where
    menori :: Int -> Int -> Int -> Int
    menori m n i
      | m <= n && m <= i = m
      | n <= i = n
      | otherwise = i

    maiori :: Int -> Int -> Int -> Int
    maiori m n i
      | m >= n && m >= i = m
      | n >= i = n
      | otherwise = i

{- Casos para tuplas
(z, x)
(z, y)
(x, y)
(x, z)
(y, x)
(y, z)
-}

menorMaior'' :: Int -> Int -> Int -> (Int, Int)
menorMaior'' x y z
  | x >= y && y >= z = (z, x)
  | y >= z && x >= z = (z, y)
  | y >= z = (x, y) -- aqui sabemos que y é menor que z
  | y >= x = (x, z) -- aqui sabemos que x é maior que y
  | x >= z = (y, x) -- aqui sabemos que z é maior que x
  | otherwise = (y, z)

{- 2ª questão
  Defina a função ordenaTripla que recebe uma tripla de inteiros e ordena a mesma.

ordenaTripla m n p
Casos:
(m, n, p) x
(m, p, n) x
(p, n, m) x
(p, m, n) x
(n, p, m) x
(n, m, p) x
-}

ordenaTripla :: (Int, Int, Int) -> (Int, Int, Int)
ordenaTripla (m, n, p)
  | m >= n && n >= p = (p, n, m)
  | n >= p && m >= p = (p, m, n) -- aqui sabemos que n é maior que m
  | m >= p = (n, p, m) -- aqui sabemos que p é maior que n
  | m >= n = (n, m, p) -- aqui sabemos que p>m p>n
  | n >= p =  (m, p, n) -- aqui sabemos que n>m p>m
  | otherwise = (m, n, p)

{- 3ª questão
  Uma linha pode ser representada da seguinte forma
type Ponto = ( Floa t , Floa t )
type Reta = (Ponto , Ponto )
• Defina funções para
– retornar a primeira coordenada de um ponto
– retornar a segunda coordenada de um ponto
– indicar se uma reta é vertical ou não ( x1 = x2)
-}

type Ponto = (Float, Float)
type Reta = (Ponto, Ponto)

fstCoord :: Ponto -> Float
fstCoord p = fst p

sndCoord :: Ponto -> Float
sndCoord p = snd p

firstCoord :: Reta -> Int -> Float
firstCoord (p, q) x
  | x == 1 = fst p
  | x == 2 = fst q

secondCoord :: Reta -> Int -> Float
secondCoord (p, q) x
  | x == 1 = snd p
  | x == 2 = snd q

vertical :: Reta -> Bool
vertical ((x1, y1), (x2, y2)) = if x1 == x2 then True else False

vertical2 :: Reta -> Bool
vertical2 r = if (firstCoord r 1) == (firstCoord r 2) then True else False

{-  4ª questão
Se uma reta é dada por:
    (y − y1)/(x − x1) = (y2 − y1)/(x2 − x1), -> (y - y1)*(x2 -x1) = (y2 - y1)*(x - x1)
defina uma função:
    pontoY :: Float −> Reta −> Float
que, dada uma coordenada x e uma reta, retorne a coordenada y, tal que o ponto (x, y) faça parte da reta.
-}

pontoY :: Float -> Reta -> Float
pontoY x r = ()