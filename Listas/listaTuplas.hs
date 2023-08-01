-- Lista de exercícios de Tuplas 2023.1

minThree :: Integer -> Integer -> Integer -> Integer
minThree a b c
    | a < b && a < c = a
    | b < c          = b
    | otherwise      = c

maxThree :: Integer -> Integer -> Integer -> Integer
maxThree a b c
    | a > b && a > c = a
    | b > c          = b
    | otherwise      = c

    -- 1. menorMaior recebe 3 inteiros e retorna tupla (menor, maior)

menorMaior :: Integer -> Integer -> Integer -> (Integer, Integer)
menorMaior x y z = ((minThree x y z), (maxThree x y z))
-- (x,z) - (x,y) - (y,x) - (y,z) - (z,x) - (z,y)

    -- 2. ordenaTripla recebe tripla de inteiros e ordena

ordenaTripla :: (Integer, Integer, Integer) -> (Integer, Integer, Integer)
ordenaTripla (x, y, z) = (minThree x y z, (x + y + z) - minThree x y z - maxThree x y z, maxThree x y z)

ordenaTripla'' :: (Integer, Integer, Integer) -> (Integer, Integer, Integer)
ordenaTripla'' (x, y, z) = let minimo = minThree x y z
                               maximo = maxThree x y z
                               total = x + y + z
                            in (minimo, total - minimo - maximo, maximo)

ordenaTripla' :: (Integer, Integer, Integer) -> (Integer, Integer, Integer)
ordenaTripla' (x, y, z)
    | (menorMaior x y z) == (x, y) = (x, z, y)
    | (menorMaior x y z) == (x, z) = (x, y, z)
    | (menorMaior x y z) == (y, z) = (y, x, z)
    | (menorMaior x y z) == (y, x) = (y, z, x)
    | (menorMaior x y z) == (z, y) = (z, x, y)
    | otherwise                    = (z, y, x)
    
-- (x, y, z) ; (x, z, y) ; (y, x, z) ; (y, z, x) ; (z, y, x) ; (z, x, y)

    -- 3. defina
    --      retornar primeira coordenada de um ponto
    --      retornar segunda coordenada de um ponto
    --      indicar se um reta é vertical ou não (x1 = x2)

type Ponto = (Float, Float) -- (x, y)
type Reta = (Ponto, Ponto)  -- ((x1, y1), (x2, y2))

fstCoordinate :: Ponto -> Float
fstCoordinate ponto = fst ponto
--fstCoordinate (x, y) = x

sndCoordinate :: Ponto -> Float
sndCoordinate ponto = snd ponto
--sndCoordinate (x, y) = y

isVertical :: Reta -> Bool
isVertical reta = if fst (fst reta) == fst (snd reta) then True else False
--isVertical ((x1, y1), (x2, y2))
--  | x1 == x2  = True
--  | otherwise = False 

    -- 4. reta = (y - y1)/(x - x1) = (y2 - y1)/(x2 - x1)
    --      pontoY recebe uma coordenada X e uma RETA, retorna a coordenada Y,
    --      tal que o ponto (x,y) faça parte da reta

pontoY :: Float -> Reta -> Float
pontoY x ((x1, y1), (x2, y2)) = (((y2 - y1)*(x - x1)) / (x2 - x1)) + y1

pontoY' :: Float -> Reta -> Float
pontoY' x reta = (((y2 - y1)*(x - x1)) / (x2 - x1)) + y1
    where
        ponto1 = fst reta
        ponto2 = snd reta
        x1 = fst ponto1
        y1 = snd ponto1
        x2 = fst ponto2
        y2 = snd ponto2
        

main :: IO()
main = do
    let ponto1 = (3.5, 8)
    let ponto2 = (3.5, 3)
    let ponto3 = (3.4, 8)
    
    let reta1 = (ponto1, ponto2)
    let reta2 = (ponto1, ponto3)

    putStrLn (show (isVertical reta1))
    putStrLn (show (isVertical reta2))