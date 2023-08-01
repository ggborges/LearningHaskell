-- 1. (a)

primos :: [Int] -> [Int]
primos [] = [] -- lista vazia retorna lista vazia
primos (0:_) = [] -- 
primos (1:_) = []
primos (x:xs) = x:[ y | y <- primos xs, mod y x /= 0]

-- 1. (b)

primosN :: Int -> [Int]
primosN n = primos[2..n]

-- 2.

-- exemplo:
-- > sublistas [1,2,3]
-- [[1,2,3],[1,2],[1,3],[1],[2,3],[2],[3],[]]

sublistas :: [a] -> [[a]]
sublistas [] = [[]]
sublistas (x:xs) = [ x:ys | ys <- sublistas xs] ++ sublistas xs

-- > sublistas [1,2,3]
-- sublistas (1:[2,3]) = [1:ys | ys <- sublistas [2,3]] ++ sublistas [2,3]
-- sublistas (2:3) = [2:ys | ys <- sublistas [3]] ++ sublistas [3]
-- sublistas (3:[]) = [3:ys | ys <- sublistas []] ++ sublistas []
-- sublistas [] = [[]]
-- sublistas (3:[]) = [[3]] ++ [[]] = [[3],[]]
-- sublistas (2:3) = [2:[[3],[]]] ++ [[3],[]]