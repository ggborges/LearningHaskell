{-  CAPÍTULO 10

We need to make the transformation or operator into a parameter of the general function; in other words we need to have functions as arguments of other functions. These higher-order functions are the topic of this chapter. Complementing this is the ability to make functions the results of functions; we look at that in the next chapter.

We begin the chapter by examining the patterns of computation over lists which we have encountered so far, and in the remaining sections of the chapter we show how these are realized as higher-order Haskell functions. We also re-examine primitive recursive
definitions, and see that they generalize the process of combining the elements of a list
using an operator.

Next we look at an example of generalization: taking a function over String into a polymorphic, higher-order function. We do this by identifying the parts of the function which make it specific to String and turning those into a parameter of the function. The example serves as a model for how we can generalize functions in any situation and so make them applicable in many more contexts.
-}
{-

    10.1 Patterns of computation over lists

         Applying to all – mapping

Many functions call for all of the elements of a list to be transformed in some way – thiswe call mapping. We have seen examples of this from the first chapter, where we notedthat to flip a picture in a vertical mirror – flipV – we needed to reverse each line of
the Picture, which is a list of lines.
  We also saw mapping in Chapter 5 in our first example of a list comprehensionwhich was to double every element of a list of integers.

doubleAll [2,3,71] = [4,6,142]

               Other examples include

  • taking the second element of each pair in a list of   pairs, as we do in the library database;
  • in the supermarket billing example, converting        every item in a list of bar codes to the                corresponding (Name,Price) pair;
  • formatting each (Name,Price) pair in a list.

        Selecting elements – filtering

Selecting all the elements of a list with a given property is also common. Chapter 5 contains the example of the function which selects the digits from a string
digits "29 February 2004" = "292004"

        Among the other cases we have seen are
  • select each pair which has a particular person as     its first element;
  • select each pair which is 'not' equal to the loan       pair being returned

        Combining the items – folding

The first example of primitive recursion in Chapter 7 was sum, which computes the total of a list of integers. The total of the list is given by folding the function + into the list, thus:

sum [2,3,71] = 2+3+71

In a similar way,
  • ++ can be folded into a list of lists to              concatenate it, as is done in the definition of         concat;
  • && can be folded into a list of Booleans to take      their conjunction: this is the prelude function and;
  • max can be folded into a list of integers to give     their maximum.

      Combinations

  These patterns of definition are often used together. In defining books for the library database, which returns all the books on loan to a given person, we filter out all pairs involving the person, and then take all second components of the results. The strength of list comprehensions is that they give this combination of mapping and filtering, which fits some examples – like the library database – particularly well.

    Primitive recursion and folding

  The form of many definitions is primitive recursive. Sorting by insertion is a classic example:

iSort [] = []
iSort (x:xs) = ins x (iSort xs)

  Haskell provides a mechanism to turn a prefix function like ins into an infix version. The name is enclosed by back quotes, ‘ins‘, so

iSort (x:xs) = x ‘ins‘ (iSort xs)

and, in a given example, we have

iSort [4,2,3] = 4 ‘ins‘ 2 ‘ins‘ 3 ‘ins‘ []

  Looked at this way, the definition looks like ‘ins‘ folded into the list [4,2,3]. We shall look at this again in Section 10.3.

-}
{-
    10.2 Higher-order functions: functions as arguments

  A function is higher-order if it takes a function as an argument or returns a function as a result, or does both. In this section we show how a variety of functions, including some of the patterns discussed in the last section, can be written using functions as arguments.

        Mapping – the map function

  We can double all the elements in an integer list in two ways, either using a list comprehension,

doubleAll :: [Integer] -> [Integer]
doubleAll xs = [ 2*x | x <- xs ]

or using primitive recursion,

doubleAll [] = []
doubleAll (x:xs) = 2*x : doubleAll xs

In both cases, we can see that the specific operation of multiplying by two is applied to an element of the list in the expression ‘2*x’.

  Suppose that we want to modify every element of a list by another operation – for instance, the function from Enum that transforms a Char into an Int – we could modify one of the definitions above by replacing the ‘2*x’ by ‘fromEnum x’ to give a different definition.
  Taking this approach would mean that we would write a whole lot of definitions which differ only in the function used to make the transformation. Instead of doing this, we can write a single definition in which the function becomes a parameter of the definition. Our general definition will be

map f xs = [f x | x <- xs] ____________ (map.0)

or we can give an explicit primitive recursion

map f [] = [] _________________________ (map.1)
map f (x:xs) = f x : map f xs _________ (map.2)

The function to double all the elements of a list can now be given by applying map to two things: the transformation – double – and the list in question.

doubleAll xs = map double xs

where double x = 2*x. In a similar way, the function to convert all the characters into their codes will be

convertChrs :: [Char] -> [Int]
convertChrs xs = map fromEnum xs

What is the type of map? It takes two arguments – the first is a function, and the second is a list – and it returns a list.

The input list is made up
of elements which we can
apply the function to.

The output list is made up
of elements from the output
type of the function.


    \input function/        \output list/
map :: (... -> ...) -> [...] -> [...]
                   /input list\

map :: ([a] -> [b]) -> [a] -> [b]

The figure shows how the types of the functions and lists are related, giving map the type

map :: (a -> b) -> [a] -> [b]

where recall that a and b are type variables, standing for arbitrary types. Instances of the type of map include

map :: (Integer -> Integer) -> [Integer] -> [Integer]

as used in the definition of doubleAll, where map is applied to the function double of type Int -> Int and

map :: (Char -> Int) -> [Char] -> [Int]

as in the definition of convertChrs.

        Modelling properties as functions

  Before defining the function to filter, or select, those elements of a list having a given property, we need to think about how such properties are to be modelled in Haskell. Take the example of filtering the digits from a string – the function digits mentioned earlier.
  How is the property of ‘being a digit’ to be modelled? We have already seen that the library Data.Char contains a function

isDigit :: Char -> Bool

and we find out whether a particular character like ’d’ is a digit or not by applying the function to the character to give a Boolean result, that is True or False.
  This is the way that we can model a property over any type t. The property isgiven by a function of type

t -> Bool

and an element x has the property precisely when f x has the value True. We have already seen the example of isDigit; other examples include

isEven :: Integer -> Bool
isEven n = (n ‘mod‘ 2 == 0)

isSorted :: [Integer] -> Bool
isSorted xs = (xs == iSort xs)

We usually adopt the convention that the names of properties begin with ‘is’.

          Filtering – the filter function

  Building on our discussion of properties, we see that the filter function will take a property and a list, and return those elements of the list having the property:

filter p [] = [] (filter.1)
filter p (x:xs)
  | p x = x : filter p xs (filter.2)
  | otherwise = filter p xs (filter.3)

  In the case of an empty list, the result is empty. For a non-empty list (x:xs) there are two cases. If the guard condition p x is true then the element x is the first element of the result list; the remainder of the result is given by selecting those elements in xs which have the property p. If p x is False, x is not included, and the result is given by
searching xs for elements with property p.
  A list comprehension also serves to define filter,

filter p xs = [x | x <- xs , p x] (filter.0)

where again we see that the condition for inclusion of x in the list is that it has the property p.
  Our example digits is defined using filter as follows:

digits xs = filter isDigit xs

  Other applications of filter give

filter isEven [2,3,4,5]  [2,4]
filter isSorted [[2,3,4,5],[3,2,5],[],[3]]  [[2,3,4,5],[],[3]]

  What is the type of filter? It takes a property and a list, and returns a list.

The function is a property:
it takes a list element to a
Boolean

The output list is made up of
elements from the input list; this is
also the input type of the function.

        \input function/       \output list/
filter :: (... -> ...) -> [...] -> [...]
                       /input list\

filter :: (a -> Bool) -> [a] -> [a]


Exercícios pág 243 do pdf
-}

{-
  10.3 Folding and primitive recursion

  In this section we look at a particular sort of higher-order function which implements the operation of folding an operator or function into a list of values. We will see that this operation is more general than we might first think, and that most primitive recursive functions over lists can, in fact, be defined using a fold.
  The definition of foldr1 will have two cases. Folding f into the singleton list [a] gives a. Folding f into a longer list is given by

foldr1 f [e1,e2,...,ek]
  = e1 ‘f‘ (e2 ‘f‘ ( ... ‘f‘ ek)...)
  = e1 ‘f‘ (foldr1 f [e2,...,ek])
  = f e1 (foldr1 f [e2,...,ek])

  The Haskell definition is therefore

foldr1 f [x] = x (foldr1.1)
foldr1 f (x:xs) = f x (foldr1 f xs) (foldr1.2)

and the type of foldr1 will be given by

foldr1 :: (a -> a -> a) -> [a] -> a

The type shows that foldr1 has two arguments.
    • The first argument is a binary function over the type a; for example, the function (+) over Int.
    • The second is a list of elements of type a which are to be combined using the operator; for instance, [3,98,1]
  
  The result is a single value of type a; in the running example we have

foldr1 (+) [3,98,1] = 102

  Other examples which use foldr1 include

foldr1 (||) [False,True,False] = True
foldr1 (++) ["Freak ", "Out" , " ", "!"] = "Freak Out!"
foldr1 min [6] = 6
foldr1 (*) [1 .. 6] = 720

  The function foldr1 gives an error when applied to an empty list argument. We can modify the definition to give an extra argument which is the value returned on the empty list, so giving a function defined on all finite lists. This function is called foldr and is defined as follows:

foldr f s [] = s (foldr.1)
foldr f s (x:xs) = f x (foldr f s xs) (foldr.2)

  The ‘r’ in the definition is for ‘fold, bracketing to the right’. Using this slightly more general function, whose type we predict is

\binary operation over type a/\list of values of type a to be combined/
foldr :: (a -> a -> a) -> a -> [a] -> a >result of type a
      /starting value of /\ type a\

we can now define some of the standard functions of Haskell,

concat :: [[a]] -> [a]
concat xs = foldr (++) [] xs
and :: [Bool] -> Bool
and bs = foldr (&&) True bs

Returning to the start of the section, we can now see why foldr1 is so called: it is fold function, designed to take a list with at least one element. We can also define foldr1
from foldr, like this

foldr1 f xs = foldr f (last xs) (init xs) (foldr1.0)

where last gives the last element of a list, and init removes that element.

With this insight about the type of foldr we can see that foldr can be used to define another whole cohort of list functions. For instance, we can reverse a list thus:
-}
rev :: [a] -> [a]
rev xs = foldr snoc [] xs

snoc :: a -> [a] -> [a]
snoc x xs = xs ++ [x]

















{-
This function is traditionally called snoc because it is like ‘cons’, :, in reverse. We can also sort a list in this way

iSort :: [Integer] -> [Integer]
iSort xs = foldr ins [] xs

Before we move on, we look for one last time at the definition of foldr

foldr f s [] = s (foldr.1)
foldr f s (x:xs) = f x (foldr f s xs) (foldr.2)

What is the effect of foldr f s? We have two cases:
  • the value at the empty list is given outright by s;
  • the value at (x:xs) is defined in terms of the value at xs, and x itself.

  This is just like the definition of primitive recursion over lists in Chapter 7.1 Because of this it is no accident that we can define many of our primitive recursive functions using foldr. It is usually mechanical to go from a primitive recursive definition to the corresponding application of foldr.
  How do the two approaches compare? It is often easier initially to think of a function definition in recursive form and only afterwards to transform it into an application of foldr. One of the advantages of making this transformation is that we might then recognize properties of the function by dint of its being a fold.

Exercícios pág 247 do pdf
-}

mapF f xs = [f x | x <- xs]

-- recursive

mapF f []     = []
mapF f (x:xs) = f x : mapF f xs

--       input function   list    output list
-- map :: (... -> ...) -> [...] -> [...]
-- map :: (a -> b) -> [a] -> [b]

    -- map :: (Integer -> Integer) -> [Integer] -> [Integer]
    -- map :: (Char -> Int) -> [Char] -> [Int]

filterF propriedade [] = []
filterF propriedade (x:xs)
  | propriedade x       = x : filterF propriedade xs
  | otherwise =     filterF propriedade xs

  -- list comprehension
filterF p xs = [ x | x <- xs , p x]

--  filter :: (... -> ...) -> [...] -> [...]

-- filter :: (a -> Bool) -> [a] -> [a]

{-   Folding - combining

foldr1 f [x] = x    ...................   (foldr1.1)
foldr1 f (x:xs) = f x (foldr1 f xs)   ...................   (foldr1.2)

foldr1 (+) [3,98,1] = 102
foldr1 (||) [False,True,False] = True
foldr1 (++) ["Freak ", "Out" , " ", "!"] = "Freak Out!"
foldr1 min [6] = 6
foldr1 (*) [1 .. 6] = 720

foldr :: (a -> a -> a) -> a -> [a] -> a

The type shows that foldr1 has two arguments.
• The first argument is a binary function over the type a; for example, the function
(+) over Int.
• The second is a list of elements of type a which are to be combined using the
operator; for instance, [3,98,1]

we can now define some of the standard functions of Haskell,

concat :: [[a]] -> [a]
concat xs = foldr (++) [] xs

and :: [Bool] -> Bool
and bs = foldr (&&) True bs

We can also define foldr1 from foldr, like this

foldr1 f xs = foldr f (last xs) (init xs) -- last devolve o último elemento da lista e init devolve a lista sem o último

foldr f s []     = s
foldr f s (x:xs) = f x (foldr f s xs)



-}

{-    >>>>> Abstração lamba <<<<<

(\x -> x+1)
(\x y -> x + y + 1)

addNum :: Int -> (Int -> Int)
addNum n = (\m -> n + m)

-}