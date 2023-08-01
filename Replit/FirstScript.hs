{- #########################################################

        FirstScript.hs
        Simon Thompson, August 2010.

######################################################### -}

module FirstScript where

--      The value size is an integer (Integer), defined to be 
--      the sum of twelve and thirteen.

size :: Integer
size = 12+13

--      The function to square an integer.

square :: Integer -> Integer
square n = n*n

--      The function to double an integer.
        
double :: Integer -> Integer
double n = 2*n

--      An example using double, square and size.
         
example :: Integer
example = double (size - square (2+2))

-- 4A QUESTÃO DA ATIVIDADE 00

doubleSquare :: Integer -> Integer
doubleSquare x = (2*x)^2





--f :: T1 -> T2 -> ... -> Tn-1 -> Tn
--f x1 x2 ... xn-1
-- | g1 = e1
-- | g2 = e2
-- .
-- .
-- .
-- | otherwise = e