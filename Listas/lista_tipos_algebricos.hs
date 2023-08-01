    --  1.

divSeg :: Float -> Float -> Maybe Float
divSeg _ 0 = Nothing
divSeg x y = Just (x / y)

safeDiv :: Int -> Int -> Either String Int
safeDiv _ 0 = Left "Divisão por zero não é permitida!"
safeDiv x y = Right (x `div` y)

    -- 2.

divSafe :: Float -> Float -> Either String Float
divSafe x 0 = Left ("(" ++ show x ++ ")/0")
divSafe x y = Right (x / y)

    -- 3.

maybeValue :: Maybe b -> b
maybeValue (Just b) = b
maybeValue Nothing  = error "Incorrect value"

mapMaybe :: (Eq b) => [a] -> (a -> Maybe b) -> [b]
mapMaybe [] _     = []
mapMaybe (x:xs) f
    | (f x) == Nothing = mapMaybe xs f
    | otherwise      = maybeValue (f x) : mapMaybe xs f

-- exemplo de uso

doublePositive :: Int -> Maybe Int
doublePositive x
    | x > 0     = Just (2*x)
    | otherwise = Nothing

    -- 4.
isLeft :: Either a b -> Bool
isLeft (Left _)  = True
isLeft (Right _) = False

fromLeft :: Either a b -> a
fromLeft (Left a)  = a
fromLeft (Right _) = error "Incorrect value"

fromRight :: Either a b -> b
fromRight (Right b) = b
fromRight (Left _)  = error "Incorrect value"


classifica :: [Either a b] -> ([a],[b])
classifica ws = (lst_l, lst_r)
    where
        lst_l = [fromLeft x  | x <- ws, isLeft x]
        lst_r = [fromRight x | x <- ws, not (isLeft x)]

    -- 5.

data Tree a = Leaf | Node a (Tree a) (Tree a)
    deriving (Show, Eq)
        --
valAtRoot :: Tree a -> Maybe a
valAtRoot Leaf         = Nothing
valAtRoot (Node a _ _) = Just a
        --
lengthT :: Tree a -> Int
lengthT Leaf = 0
lengthT (Node _ t1 t2) = 1 + lengthT t1 + lengthT t2
        --
maisEsq :: (Eq a) => Tree a -> Maybe a
maisEsq Leaf = Nothing
maisEsq (Node x l _)
    | l == Leaf = Just x
    | otherwise = maisEsq l

maisEsq' :: Tree a -> Maybe a
maisEsq' Leaf = Nothing
maisEsq' (Node a Leaf _) = Just a
maisEsq' (Node _ l _)    = maisEsq' l

    --

mapTree :: (a -> a) -> Tree a -> Tree a
mapTree _ Leaf = Leaf
mapTree f (Node a t1 t2) = Node (f a) (mapTree f t1) (mapTree f t2)





    -------------------------------
--main = interact $ show . (read :: String -> Lampada)
--main = interact $ show . potencia . (read :: String -> Lustre)
main = interact $ show . balanceado . (read :: String -> Lustre)

type Nome = String
type Potencia = Int
-- Lampada
data Lampada = Compacta Nome Potencia | Incandescente Nome Potencia
    deriving (Read)

instance Show Lampada where
    show (Compacta n p) = "Compacta " ++ n ++ " " ++ show p
    show (Incandescente n p) = "Incandescente " ++ n ++ " " ++ show p

-- Lustres

data Lustre = Pendente Lampada | Barra Lustre Lustre
    deriving (Read)

potencia :: Lustre -> Int
potencia (Pendente (Compacta _ p)) = p
potencia (Pendente (Incandescente _ p)) = p
potencia (Barra l1 l2) = (potencia l1) + (potencia l2)

-- Balanceado

balanceado :: Lustre -> Bool
balanceado (Pendente _)  = True
balanceado (Barra l1 l2) = (potencia l1 == potencia l2) && (balanceado l1) && (balanceado l2)
