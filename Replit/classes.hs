{-
Defining the equality class, Eq
How do we define a class, such as Eq? We say what is needed for a type a to be in a class. In this case we need a function == defined over a, of type a -> a -> Bool.
 
class Eq a where
  (==) :: a -> a -> Bool

-}