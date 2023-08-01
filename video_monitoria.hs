


merge :: Ord a => [a] -> [a] -> [a]
merge [] [] = []
merge [] ws = ws
merge ws [] = ws
merge (x:xs) (y:ys)
    | x <= y = x : merge xs (y:ys)
    | otherwise = y : merge (x:xs) ys

metade :: (Num a) => [a] -> ([a],[a])
metade [] = ([],[])
metade xs = (allPar xs, allImpar xs)

allPar :: (Num a, Eq a) => [a] -> [a]
allPar [] = []
allPar xs = [x | x <- xs, (x `mod` 2) == 0]

allImpar :: (Num a, Eq a) => [a] -> [a]
allImpar [] = []
allImpar xs = [x | x <- xs, not ((x `mod` 2) == 0)]