


merge :: Ord a => [a] -> [a] -> [a]
merge [] [] = []
merge [] ws = ws
merge ws [] = ws
merge (x:xs) (y:ys)
    | x <= y = x : merge xs (y:ys)
    | otherwise = y : merge (x:xs) ys

-- ---------------------------

metade :: [a] -> ([a],[a])
metade [] = ([],[])
metade xs = ((allPar xs 0), (allImpar xs 0))

allPar :: [a] -> Int -> [a]
allPar [] _ = []
allPar (x:xs) i
    | mod i 2 == 0 = x : allPar xs (i+1)
    | otherwise    = allPar xs (i+1)

allImpar :: [a] -> Int -> [a]
allImpar [] _ = []
allImpar (x:xs) i
    | mod i 2 /= 0 = x : allImpar xs (i+1)
    | otherwise    = allImpar xs (i+1)


mSort :: Ord a => [a] -> [a]
mSort []  = []
mSort [x] = [x]
mSort xs  = let (metade1, metade2) = metade xs
            in merge (mSort (metade1)) (mSort metade2)