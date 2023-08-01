{-
    o> Listas

  - Coleções de elementes de um MESMO TIPO
      - [1, 2, 3, 4, 5] :: [Int] -> Lista de inteiros
      - [(5, True), (7, True), (2, False)] :: [(Int, Bool)] -> Lista de tuplas de inteiro e boolean
      - [[4, 2], [3, 7, 7, 1], [], [9]] :: [[Int]] -> Lista de listas de inteiros
      - ['b', 'o', 'm'] :: [Char] -> Lista de caracteres
      - "bom" :: [Char] -> Lista de caracteres

  - String é uma lista de caracteres:
      - type String = [Char]
      - [] é uma lista vazia de qualquer tipo
      - Listas são estruturas de dados recursivas

    o> Funções sobre listas

  - head :: [a] -> a (Lista -> Elemento_da_lista)
      ->head [1, 2, 3, 4, 5]
      - 1

      ->head "abc"
      - 'a'

  - tail :: [a] -> [a] (Lista -> Lista)
      ->tail [1, 2, 3, 4, 5]
      - [2, 3, 4, 5]

      ->tail "abc"
      - "bc"

  - init :: [a] -> [a] (Lista -> Lista)
      ->init [1, 2, 3, 4, 5]
      - [1, 2, 3, 4]

      ->init "abc"
      - "ab"

  - last :: [a] -> a (Lista -> Elemento_da_lista)
      ->last [1, 2, 3, 4, 5]
      - 5

      ->last "abc"
      - 'c'

    o> Construtor de listas (:)

  - [5] é o mesmo que 5:[]
  - [4, 5] é o mesmo que 4:(5:[])
  - [2, 3, 4, 5] é o mesmo que 2:3:4:5:[]
    ->(:) 1 [] - Forma prefixada
    - [1]
    ->1:[] - Forma infixa
    - [1]
    ->[1,2,3] == 1:2:3:[]
    - True

  (:) é um construtor polimórfico
    - (:) :: t -> [t] -> [t]
    - (:) :: Int -> [Int] -> [Int]
    - (:) :: Bool -> [Bool] -> [Bool]
    - (:) :: Float -> [Float] -> [Float]

    Mais exemplos:
    - [2..7] = [2,3,4,5,6,7]
    - [-1..3] = [-1,0,1,2,3]
    - ['a'..'d'] = ['a','b','c','d']
    - [2.8..5.0] = [2.8,3.8,4.8]
    - [7,5..0] = [7,5,3,1]
    - [2.8,3.3..5.0] = [2.8,3.3,3.8,4.3,4.8]
    - ['a','c'..'n'] = ['a','c','e','g','i','k','m'] = "acegikm"

1-

Suppose that the list ex is [2,4,7], then the list comprehension
[ 2*n | n <-ex] (1)
will be
[4,8,14]
as it contains each of the elements n of the list ex, doubled: 2*n. We can read (1) as saying
‘Take all 2*n where n comes from ex.’
where the symbol <- is meant to resemble the mathematical symbol for being an element,
‘∈’. We can write the evaluation of the list comprehension in a table, thus:
[ 2*n | n <- [2,4,7] ]
n   = 2 4 7
2*n = 4 8 14

2-

In a similar way,
[ isEven n | n<-ex ]  [True,True,False]
if the function isEven has the definition

isEven :: Integer -> Bool
isEven n = (n ‘mod‘ 2 == 0)

In list comprehensions n<-ex is called a generator because it generates the data from which the results are built. On the left-hand side of the ‘<-’ there is a variable, n, while on the right-hand side we put the list, in this case ex, from which the elements are taken.

3-

We can combine a generator with one or more tests, which are Boolean expressions, thus:
[ 2*n | n <- ex , isEven n , n>3 ] (2)
(2) is paraphrased as
‘Take all 2*n where n comes from ex, n is even and greater than 3.’

Again, we can write the evaluation in tabular form.
[ 2*n | n <- [2,4,7] , isEven n , n>3 ]
       n = 2 4 7
isEven n = T T F
     n>3 = F T
     2*n =   8
The result of (2) will therefore be the list [8], as 4 is the only even element of [2,4,7] which is greater than 3

4-

Instead of placing a variable to the left of the arrow ‘<-’, we can put a pattern. For instance,
-}
addPairs :: [(Integer,Integer)] -> [Integer]
addPairs pairList = [ m+n | (m,n) <- pairList ]
{-
Here we choose all the pairs in the list pairList, and add their components to give a single number in the result list. For example,

[ m+n | (m,n) <- [(2,3),(2,1),(7,8)] ]
  m = 2 2 7
  n = 3 1 8
m+n = 5 3 15

giving the result

addPairs [(2,3),(2,1),(7,8)] -> [5,3,15]

5-

We can add tests in such a situation, too:

addOrdPairs :: [(Integer,Integer)] -> [Integer]
addOrdPairs pairList = [ m+n | (m,n) <- pairList , m<n ]

so that with the same input example,

[ m+n | (m,n) <- [(2,3),(2,1),(7,8)] , m<n ]
  m = 2 2 7
  n = 3 1 8
m<n = T F T
m+n = 5   15

giving

addOrdPairs [(2,3),(2,1),(7,8)] -> [5,15]

since the second pair in the list, (2,1), fails the test.

6-

Note that we can simply test elements, with the effect that we filter some of the elements of a list, according to a Boolean condition. To find all the digits in a string we can say

digits :: String -> String
digits st = [ ch | ch<-st , isDigit ch ]

where the function

isDigit :: Char -> Bool

imported from the module Data.Char is True on those characters which are digits: ’0’, ’1’ up to ’9’.

7-

  A list comprehension can form a part of a larger function definition. Suppose that we want to check whether all members of a list of integers are even, or all are odd. We can write

allEven xs = (xs == [x | x<-xs, isEven x])
allOdd xs = ([] == [x | x<-xs, isEven x])

We will see list comprehensions in practice in the next section when we examine a simple library database.

8-

The pattern on the left-hand side of an arrow need not match everything in the list, take the example:

totalRadii :: [Shape] -> Float
totalRadii shapes = sum [r | Circle r <- shapes]

The effect of this is to match only the circles in the shapes list, and to ignore any other shapes, so that, for example

totalRadii [Circle 2.1, Rectangle 2.1 3.2, Circle 4.7]  6.8

This also applies to patterns for built-in types, so we can define

sings :: [[Integer]] -> [Integer]
sings xss = [x | [x] <-xss ]

which extracts all singleton elements from a list of lists:

sings [[],[1],[2,3],[4],[5,6,7],[8]] -> [1,4,8]

-}

-- 5.7 A Library DataBase [pág. 139 do pdf / pág. 116 do livro]

type Person = String
type Book = String

-- 7.2 Lists and list patterns
{-
Every list is either empty, [], or is non-empty. In the latter case – take the example [4,2,3] – then it can be written in the form x:xs, where x is the first item in the list and xs is the remainder of the list; in our example, we have 4:[2,3]. We call 4 the head of
the list and [2,3] the tail

o> Pattern-matching definitions

If we want to make a definition covering all cases of lists we can write

fun xs = ....

but more often than not we will want to distinguish between empty and non-empty cases, as in the prelude functions

head :: [a] -> a
head (x:_) = x

tail :: [a] -> [a]
tail (_:xs) = xs

null :: [a] -> Bool
null [] = True
null (_:_) = False

Patterns and parentheses

A pattern involving a constructor like ‘:’ will always have to be parenthesized, since function application binds more tightly than any other operation. This means that writing

f x:xs

will be interpreted as

(f x):xs

and not as

f (x:xs)

as we might like.

-------------------

We can now go back to the final case of pattern matching. A constructor pattern over lists will either be [] or will have the form (p:ps) where p and ps are themselves patterns.

• A list matches [] exactly when it is empty.
• A list will match the pattern (p:ps) if it is non-empty, and also if its head matchesthe pattern p and its tail the pattern ps.

In the case of the pattern (x:xs), it is sufficient for the argument to be non-empty to match the pattern; the head of the argument is matched with x and its tail with xs. Let’s look at some examples in more detail.

• The list [2,3,4] will match (p:ps), because 2 is matched with p and [3,4] with ps.
• The list [2,3,4] will match (q:(p:ps)), because 2 is matched with q, 3 is matched with p and [4] with ps.
• The list [5] will not match (q:(p:ps)); this is because 5 can match with q, but [] cannot be matched with (p:ps).
-}

-- 7.3 Primitive recursion over lists
{-
Suppose we are to find the sum of a list of integers. Just as we described calculating factorial in Section 4.4, we can think of laying out the values of sum in a table thus:

sum [] = 0
.... sum [5] = 5 ....
.... sum [7,5] = 12 ....
.... sum [2,7,5] = 14 ....
.... sum [3,2,7,5] = 17 ....
....

and just as in the case of factorial, we can describe the table by describing the first line and how to go from one line to the next, as follows:
-}

sum :: [Integer] -> Integer
sum [] = 0
sum (x:xs) = x + sum xs

{-
sum [3,2,7,5]
-> 3 + sum [2,7,5]
-> 3 + (2 + sum [7,5])
-> 3 + (2 + (7 + sum [5]))
-> 3 + (2 + (7 + (5 + sum [])))

and now we can use the equation (sum.1) and integer arithmetic to give

-> 3 + (2 + (7 + (5 + 0)))
-> 17

concat :: [[a]] -> [a] -- concat [e1,e2,...,en] = e1++e2++...++en
concat [] = []
concat (x:xs) = x ++ concat xs

zip :: [a] -> [b] -> [(a,b)]

with the examples
zip [1,5] [’c’,’d’] = [(1,’c’), (5,’d’)]
zip [1,5] [’c’,’d’,’e’] = [(1,’c’), (5,’d’)]

If each of the lists is non-empty, we form a pair from their heads, and then zip their tails, giving

zip (x:xs) (y:ys) = (x, y) : zip xs ys

but in all other cases – that is when at least one of the lists is empty – the result is empty:

zip _ _ = []

zip :: [a] -> [b] -> [(a,b)]
zip [] zs         = []
zip (x:xs) []     = []
zip (x:xs) (y:ys) = (x,y) : zip xs ys

unzip :: [(a,b)] -> ([a],[b])

Note that we have used the fact that ‘:’ is right associative in writing this calculation.

-}

{-
Capitulo 6
  6.1 Generic Functions: Polymorphism
  6.2 Haskell list functions in the Prelude <<<

-}