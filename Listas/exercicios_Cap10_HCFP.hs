    --                                                       ........    10.1    ........

-- Compreensão de lista (list comprehension)
doubleAllv1 :: [Int] -> [Int]
doubleAllv1 []    = []
doubleAllv1 lista = [ 2*x | x <- lista ]


-- Recursão primitiva (primitive recursion)
doubleAllv2 :: [Int] -> [Int]
doubleAllv2 [] = []
doubleAllv2 (x:xs) = (x+x) : doubleAllv2 xs

-- Mapeamento (mapping)
doubleAllv3 :: [Int] ->[Int]
doubleAllv3 xs = map double xs
    where
        double x = 2 * x

doubleAllv4 :: [Int] ->[Int]
doubleAllv4 xs = map (*2) xs

doubleAllv5 :: [Int] ->[Int]
doubleAllv5 xs = map (\x -> 2 * x) xs


    --                                                      .......    10.2    .......

lengthF :: [Int] -> Int
lengthF as = sum (map (\x -> x `div` x) as)

lengthF1 :: [Int] -> Int
lengthF1 as = sum (map (\x -> 1) as)

    --                                                      .......    10.3    .......

addUp' :: [Int] -> [Int]
addUp' ns = filter greaterOne (map addOne ns)
    where
        greaterOne x = x > 1
        addOne x = x + 1

addUp1' :: [Int] -> [Int]
addUp1' ns = filter (> 1) (map (+ 1) ns)

addUp :: [Int] -> [Int]
addUp ns = map addOne (filter greaterZero ns)
    where
        addOne x = x + 1
        greaterZero x = x > 0

addUp1 :: [Int] -> [Int]
addUp1 ns = map (+ 1) (filter (> 0) ns)

    --                                                      .......    10.4    .......

    --                                                      .......    10.5    .......

test ns = filter (> 1) (filter (< 10) ns)

    --                                                      .......    10.6    .......

squareAll :: [Int] -> [Int]
squareAll ns = map (^ 2) ns

squareAll1 :: [Int] -> [Int]
squareAll1 = map (^ 2)
    --
sumSquareAll :: [Int] -> Int
sumSquareAll ns = foldr (+) ((last ns) ^ 2) (map (^2) (init ns))

sumSquareAll1 :: [Int] -> Int
sumSquareAll1 ns = foldr1 (+) (map (^2) ns)

sumSquareAll2 :: [Int] -> Int
sumSquareAll2 = sum . map (^2)
    --
greaterZeroAll :: [Int] -> Bool
greaterZeroAll ns = foldr1 (&&) (map (\x -> x > 0) ns)

    --                                                      .......    10.7    .......

addNum :: Int -> (Int -> Int)
addNum n = (\m -> n + m)

-- /2 2000 = 1000
-- 2/ 2000 = 1.0e-3