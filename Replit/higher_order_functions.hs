{-  CAPÍTULO 11

  Haskell is a functional programming language: that means that the main way in which we compute things is by defining functions which describe how to transform the inputs into the required output.

  Haskell has a collection of built-in data types which we can use to model the data in the problem domain, including numbers, booleans, lists, tuples and
data types.
  Haskell is also functional in a more distinctive way: functions are data in Haskell, and can be treated just like data of any other type.

  • Functions can be combined using operators, just like the numbers can be combined using the arithmetical operators.
  • Haskell provides lambda abstractions, which allow us to describe functions directly by expressions, rather than having to define and name a function in order to use it.
  • Functions can be the inputs and outputs of other functions in exactly the same way as any other type. Functions which have other functions as arguments or results are called higher-order functions.
  • In particular, the syntax of Haskell makes it particularly easy to partially apply functions and operators, so that functions are returned as the results of applying functions.

-}

{-  11.1 Operators: function composition and application

  This section describes the built-in operators for function composition and application, as well as defining a new operator, forward composition, which composes functions in the ‘natural’ order.

        Function composition:

  Function composition is one of the simplest ways of structuring a program: do a number of things one after the other: each part can be designed and implemented separately.
  Haskell has the function composition operator over functions built in. The operator, which is denoted by the ‘.’ between the two functions, has the effect of ‘wiring together’ two functions: passing the output of one to the input of another, and it is.

  For any functions f and g, the effect of f.g is given by the definition

(f.g) x = f (g x) (comp.1)

  Not all pairs of functions can be composed. The output of g, g x, becomes the input of f, so that the output type of g must equal the input type of f.

In general, the constraint on which functions can be composed is expressed by giving ‘.’ the type

     \type of f/           \type of (f.g)/
(.) :: (b -> c) -> (a -> b) -> (a -> c)
                 /type of g\

which shows that, if we call the first input f and the second g,

  • The input of f and the output of g are of the same type: b.
  • The result f.g has the same input type, a, as g and the same output type, c, as f.

  Composition is associative, that is f.(g.h) is equal to (f.g).h for all f, g and h. We can therefore write f.g.h unambiguously to mean ‘do h, then g, then f’.
[For technical reasons, the ‘.’ is treated as right associative in the Haskell standard prelude.]

        Forward composition: >.>

  The order in f.g is significant, and can be confusing; (f.g) means ‘first apply g and then apply f to the result’, so the function that is applied first comes second in the composition.

  It is simple in Haskell to define an operator for composition which takes its arguments in the opposite order to ‘.’, like this:

infixl 9 >.>

(>.>) :: (a -> b) -> (b -> c) -> (a -> c)

g >.> f = f . g (fcomp.1)

  This definition has the effect that

(g >.> f) x = (f.g) x = f (g x) (fcomp.2)

showing that, as it were, the order of the f and g is swapped before the functions are applied.

  The notation ‘>.>’ contains a ‘.’ to show that it is a form of composition, with the arrows showing the direction in which information is flowing.
  We will tend to use ‘>.>’ in situations where a number of functions are composed, and it is therefore tiresome to read some lines down the page in order to work out the effect of a function definition.

        The application operator: $

  We’re familiar in Haskell with how to write the application of a function f to an argument e: we just write f next to e, like this: f e. In other words, we juxtapose the function and its argument.
  We can also explicitly write down an application using the application operator, ‘$’, like this: f$e. Why on earth would we want to do this, when we can write it without the ‘$’?
 There are two reasons that an explicit application gets used:

  • Many Haskell programmers use ‘$’ as an alternative to parentheses, so you may well see this in libraries that people have written. Instead of writing something like:

flipV (flipH (rotate horse))

it is possible to write:

flipV $ flipH $ rotate horse

with the same meaning. Arguably this is a little clearer, and it is shorter! Incidentally you can see from this example that ‘$’ is right associative.
  • We need to use the application operator as a function, as in the example:

zipWith ($) [sum,product] [[1,2],[3,4]]

where the application operator is applied to corresponding elements of the two lists.

        #Application and composition#

  Application and composition can get confused. Function composition combines two functions, while application combines a function and an argument (which can be a function, of course).

  If, for example, f has type Integer -> Bool, then

  – f.x means f composed with the function x; x therefore needs to be of type s -> Integer for some type s.
  – f x means f applied to the object x, so x must therefore be an integer.
  – f $ x also means f applied to the object x, and so x must again be an integer.

Exercícios pág 258 do pdf
-}

{-  11.2 Expressions for functions: lambd abstractions

  Haskell definitions give us a way of defining functions, and once we have defined a function we can use its name to refer to it, as in the application map 

addOne [2,3,4]

assuming that we’ve already defined

addOne x = x+1

  Haskell gives us a way of writing down an expression that means ‘the function that adds one to a number’ directly, without having to give it a name. We write

\x -> x+1

which we can read as saying ‘the function that takes x to x+1’, the initial ‘\’ signalling that it’s a function. 
  So, we can add one to all the numbers in the list [2,3,4] by writing the expression

map (\x -> x+1) [2,3,4]

An expression like (\x -> x+1) is called a lambda abstraction.

        Examples of lambda abstractions

  Let’s take a look at some other uses of this notation now. Suppose that we want to take a list of functions and apply them all to a particular argument,

mapFuns :: [a->b] -> a -> [b]

giving a list of results. We might do this in playing a game of Rock – Paper – Scissors where we apply a number of different strategies to the current game position, and then compare the different results; we’ll come back to this scenario later in the chapter.
  We could define the function by recursion, like this:

mapFuns [] x = []
mapFuns (f:fs) x=fx: mapFuns fs x

but in fact we can use map in making the definition: what we have to do at each element of the list (remember, each element is a function) is to apply it to x, so

mapFuns fs x = map (\f -> f x) fs

  What’s important to see here is that the function (\f -> f x) depends on the value of x, and so we cannot define it as a top level function. We could, alternatively, define it in a where clause,

mapFuns fs x = map applyToX fs
  where
  applyToX f = f x

  The first definition is clearer, and defines the operative function directly, rather than having to name and define it in a where clause, separately from where it is used; of course, either is OK, and it’s a matter of taste which you might use.
  One of the main uses of lambda abstractions is to define functions which are the results of functions. Let’s look at the example of the function

addNum :: Integer -> (Integer -> Integer)

The function takes an integer, 17 say, and returns a function: in this case the function that adds 17 to its argument. The definition says this directly:

addNum n = (\m -> n+m)
-}

{-  11.3 Partial Application

  In this section we’ll discover how it is possible to partially apply functions in Haskell, and what the effect of this is. Underlying the Haskell approach to functions is what is called the curried representation of functions, in honour of Haskell Curry; this is introduced in the section after this.

        Introducing partial application

  The function multiply multiplies together two arguments,

multiply :: Int -> Int -> Int
multiply x y = x*y

  If we apply the function to two arguments, the result is a number; so that, for instance, multiply 2 3 equals 6.
  What happens if multiply is applied to one argument 2? This function will, when given the awaited argument y, return double its value, namely 2*y.
  This is an example of a general phenomenon: any function taking two or more arguments can be partially applied to one or more arguments. This gives a powerful
way of forming functions as results.

        Example: the doubleAll function

  To illustrate, we take the example of the function which doubles every element in a list of integers. The function can be defined like this:

doubleAll :: [Int] -> [Int]
doubleAll = map (multiply 2)

In this definition there are two partial applications:

  • multiply 2 is a function from integers to integers, given by applying multiply to one rather than two arguments;
  • map (multiply 2) is a function from [Int] to [Int], given by partially applying map.

  Partial application is being put to two different uses here.
  • In the first case – multiply 2 – the partial application is used to form the function which multiplies by two, and which is passed to map to form the doubleAll function.
  • the second partial application – of map to multiply 2 – could be avoided by writing the argument to 

doubleAll
doubleAll xs = map (multiply 2) xs

but it is quite possible to write a function level definition like this, and it is shorter and clearer than the definition with the arguments supplied.

        Partially applied operators: operator sections

  The operators of the language can be partially applied, giving what are known as operator sections. Examples include

-(+2) The function which adds two to its argument.
-(2+) The function which adds two to its argument.
-(>2) The function which returns whether a number is greater than two.
-(3:) The function which puts the number 3 on the front of a list.
-(++"\n") The function which puts a newline at the end of a string.
-("\n"++) The function which puts a newline at the beginning of a string.
-($ 3) The function which applies its argument – which will have to be a function – to the integer 3.

  The general rule here is that a section of the operator op will put its argument to the side which completes the application. That is, 

(op x) y = y op x
(x op) y = x op y

  When combined with higher-order functions like map, filter and composition, the notation is both powerful and elegant, enabling us to make a whole lot more functionlevel definitions. For example,

filter (>0) . map (+1)

is the function which adds one to each member of a list, and then removes those elements which are not positive.

        Using partial applications

  The partial application and operator sections is important in Haskell programming. We have already seen that many functions can be defined as specializations of general operations like map, filter and so on. These specializations arise by passing a function to the general operation – this function is often given by a partial application.

  Examples of partial applications will be seen throughout the material to come, and can be used to simplify and clarify many of the preceding examples. Three simple examples are the text processing functions we first looked at in Section 7.6:

dropSpace = dropWhile (member whitespace)
dropWord = dropWhile (not . member whitespace)
getWord = takeWhile (not . member whitespace)

where:

member xs x = elem x xs

Exercícios pág 265 do pdf
-}

{-        Parentheses in Haskell

  The main role of parentheses, ( ... ), in Haskell is to group items together so that the system interprets what you have written in the right way. Typical examples
include

  • enclosing a pattern in a definition, as in sum (Node t1 t2) = ...;
  • enclosing a negative literal in a function application, as in fac (-1);
  • enclosing a type annotation, as in foldr plus (1::Int) [1..1000];
  • overriding the binding power of operators, as in (2+3)*6;
  • grouping names in a deriving clause like deriving (Eq, Show).

  However, other uses of parentheses have an effect of building data elements or changing the meaning of an identifier.

  • To form a tuple, it is necessary to enclose the items in parentheses, as in (1,True); the notation 1,True on its own is meaningless.
  • To turn an infix operator into a prefix operator, it must be enclosed in parentheses, as in (&&).
  • To form an operator section, the operator and arguments are enclosed in parentheses as seen in this example: (&& True).(0 /=).(‘rem‘ 2).
-}

inc :: Int -> Int
inc x = x + 1

ehPar :: Int -> Bool
ehPar x = mod x 2 == 0

twice :: (t -> t) -> (t -> t)
twice f = f . f

iter :: Int -> (t -> t) -> (t -> t)
iter 0 f = id
iter n f = (iter (n-1) f) . f

{-
(iter 2 inc) 2
= ((iter 1 inc) . inc) 2
= (((iter 0 inc) . inc) . inc) 2
= ((id . inc) . inc) 2
= (id . inc) 3
= id 4
= 4
-}

