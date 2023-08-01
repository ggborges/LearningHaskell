-- Podemos ter tuplas de diferentes tipos (Int, Bool), (Bool, Char, Int)

fibPair :: Integer -> (Integer, Integer)
fibPair n
    | n == 0 = (0, 1)
    | otherwise = fibStep (fibPair (n-1))


fibStep :: (Integer, Integer) -> (Integer, Integer)
fibStep (u, v) = (v, u+v)

fastFib :: Integer -> Integer
fastFib n = fst (fibPair n)

-- --------------------------------

    -- Raízes

umaRaiz :: Float -> Float -> Float -> Float
umaRaiz a b _ = -b / (2 * a) -- b² = 4*a*c ((-b+-sqrt(b²-4ac))/2a) - a raiz resulta 0,
                             -- logo simplifica-se para -b/2a

duasRaizes :: Float -> Float -> Float -> (Float, Float)
duasRaizes a b c = ((d - e), (d + e))
    where
        d = -b / (2*a)
        e = sqrt ((b ^ 2) - 4.0*a*c) / (2.0 * a)

raizes :: Float -> Float -> Float -> String
raizes a b c
    | (b ^ 2) == 4.0*a*c = show (umaRaiz a b c)
    | (b ^ 2) < 4.0*a*c = show f ++ " " ++ show s
    | otherwise = "Não há raízes"
        where
            (f, s) = duasRaizes a b c
            -- f = fst (duasRaizes a b c)
            -- s = snd (duasRaizes a b c)

    -- Sinônimos de tipos
    
type Nome = String
type Idade = Integer
type Telefone = Integer
type Person = (Nome, Idade, Telefone)

nome :: Person -> Nome
nome (nome, idade, telefone) = nome


main :: IO()
main = do
    let pessoa = ("Gustavo", 27, 81994711791)
    putStrLn (show (nome pessoa))



 