import System.IO

main :: IO()
main = do
    putStrLn "Digite um texto:"
    entrada <- getLine
    putStrLn ("Você digitou: " ++ entrada)

    putStrLn "Digite um número inteiro:"
    entrada <- readLn :: IO Int
    putStrLn ("Você digitou: " ++ show entrada)

    putStrLn "Digite um ponto flutuante:"
    entrada <- readLn :: IO Float
    putStrLn ("Você digitou: " ++ show entrada)

    putStrLn "Digite um caractere:"
    entrada <- getChar
    putStrLn ("Você digitou: " ++ show entrada)