        --      Overloading

elemGen :: (Eq a) => a -> [a] -> Bool
elemGen _ [] = False
elemGen x (y:ys) = (x == y) || elemGen x ys

    --  Defining the Equality class (Eq)

{-class Eqy a where
    (==) :: a -> a -> Bool
-}
    --

class Info a where
    examples :: [a]
    size     :: a -> Int

            {-  General form of a class definition
            
            class Name ty where
                ...signature involving the type variable 'ty'
            -}

    -- Defining the instance of a class

            {-
            instance Eq Bool where
                True  == True  = True
                False == False = True
                _     == _     = False
            -}

instance Info Char where
    examples = ['a','A','z','Z', '0','9']
    size _   = 1

instance Info Bool where
    examples = [True, False]
    size _   = 1

instance Info Int where
    examples = [-100..100]
    size _   = 1

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

instance Info Shape where
    examples = [Circulo 3.0, Retangulo 45.9 87.6]
    size     = round . area

    -------------------
    {-
    class Eq a where
        (==), (/=) :: a -> a -> Bool
        x /= y     = not (x == y)
        x == y     = not
    -}

class Info1 a where
    examples1 :: [a]
    size1     :: a -> Int
    size1 _   = 1

instance Info1 Int where
    examples1 = [-100..100]

instance Info1 Bool where
    examples1 = [True, False]

instance Info1 Char where
    examples1 = ['a','A','z','Z','0','9']


lookupFirst :: Eq a => [(a,b)] -> a -> [b]
lookupFirst ws x = [ z | (y, z) <- ws, y == x]

vlookupFirst :: (Eq a, Show b) => [(a,b)] -> a -> [b]
vlookupFirst ws x = [ z | (y,z) <- ws, y == x]

    -- Assinatura vazia (empty signature)

class (Ord a, Show a) => OrdShow a
    {-Neste caso específico, a declaração de classe contém uma assinatura vazia. Para estar em OrdShow, o tipo 'a' precisa simplesmente estar nas classes Ord e Show. Podemos então modificar o tipo de vSort para dizer:-}


    {-  Built-in Haskell classes
    Ordering

        class (Eq a) => Ord a where
            compare             :: a -> a -> Ordering
            (<), (<=),(>=), (>) :: a -> a -> Bool
            max, min            :: a -> a -> a

        data Ordering = LT | EQ | GT 

        compare x y
            | x == y    = EQ
            | x < y     = LT
            | otherwise = GT

        The defaults also contain definitions of the ordering operators from compare:
            x <= y = compare x y /= GT
            x <  y = compare x y == LT
            x >= y = compare x y /= LT
            x >  y = compare x y == GT

        max x y
            | x <= y    = y
            | otherwise = x

        min x y
            | x <= y    = x
            | otherwise = y

    Enumeration: Enum

        [2,4..8]

        class (Ord a) => Enum a where
            succ, pred      :: a -> a
            toEnum          :: Int -> a
            fromEnum        :: a -> Int
            enumFrom        :: a -> [a]             [n .. ]
            enumFromThen    :: a -> a -> [a]        [n, m .. ]
            enumFromTo      :: a -> a -> [a]        [n .. m]
            enumFromThenTo  :: a -> a -> a -> [a]   [n, n' .. ]

        class (Real a, Enum a) => Integral a where
            quot :: a -> a -> a
            rem :: a -> a -> a
            div :: a -> a -> a
            mod :: a -> a -> a
            toInteger :: a -> Integer

        class Num a => Fractional a where
            (/) :: a -> a -> a
            recip :: a -> a
            fromRational :: Rational -> a

        class Fractional a => Floating a where
            pi :: a
            exp :: a -> a
            log :: a -> a
            sqrt :: a -> a
            (**) :: a -> a -> a
            logBase :: a -> a -> a
            sin :: a -> a
            cos :: a -> a
            tan :: a -> a
            asin :: a -> a
            acos :: a -> a
            atan :: a -> a
            sinh :: a -> a
            cosh :: a -> a
            tanh :: a -> a
            asinh :: a -> a
            acosh :: a -> a
            atanh :: a -> a

        
    -}