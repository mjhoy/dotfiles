module FunctorLaws where

-- The functor laws:
-- 1) fmap id = id
-- 2) fmap g . fmap h = fmap (g . h)

-- A "computation counter" that adds up number of times `fmap` was
-- applied.

data Counter a = Counter Int a
  deriving (Show, Eq)

instance Functor Counter where
  fmap f (Counter c x) = Counter (c + 1) (f x)

-- Breaks law 1:
-- ghci> let a = Counter 0 "testing"
-- ghci> let b = id <$> a
-- ghci> a == b
-- False

-- It will also break law 2:
--
-- ghci> fmap (++ " and testing") . fmap (++ " and again") $ a
-- Counter 2 "testing and again and testing"
--
-- vs
--
-- ghci> fmap ((++ " and testing") . (++ " and again")) a
-- Counter 1 "testing and again and testing"

-- A version of Maybe that simply returns Nothing from any `fmap`.

data MaybeNot a = JustNot a | NothingNot
  deriving (Show, Eq)

instance Functor MaybeNot where
  fmap f _ = NothingNot

-- This breaks law 1:
-- ghci> id (JustNot 1) == fmap id (JustNot 1)
-- False
