-- Lista de funções

    -- 12.
addEspacos :: Integer -> String
addEspacos 1 = " "
addEspacos n = addEspacos(n - 1) ++ " "
    -- 13.
paraDireita :: Integer -> String -> String
paraDireita n str = addEspacos n ++ str

    -- 14.

imprimeTabela :: Integer -> String
imprimeTabela n = concat["Semana\tVenda\n"
               ++ imprimeSemanas n
               ++ imprimeTotal n
               ++ imprimeMedia n]


imprimeSemanas :: Integer -> String
imprimeSemanas n = tailSemana 0 n

tailSemana :: Integer -> Integer -> String
tailSemana i n = if i < n then concat[show i ++ "\t" ++ show (vendaSemana i) ++ "\n" ++ tailSemana (i+1) n]
                 else concat[show n ++ "\t" ++ show (vendaSemana n) ++ "\n"]

vendaSemana :: Integer -> Integer
vendaSemana 0 = 12
vendaSemana 1 = 14
vendaSemana 2 = 15
vendaSemana _ = 0

totalSemanas :: Integer -> Integer
totalSemanas 0 = vendaSemana 0
totalSemanas n = vendaSemana n + totalSemanas (n-1)

imprimeMedia :: Integer -> String
imprimeMedia n = concat["Media\t" ++ show (div (totalSemanas n) n)]

imprimeTotal :: Integer -> String
imprimeTotal n = concat["Total\t" ++ show (totalSemanas n) ++ "\n"]

