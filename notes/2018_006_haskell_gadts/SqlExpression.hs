{-# LANGUAGE GADTs #-}

-- GADTs are needed for pattern matching and type inference in e.g.
--     eval (B x) = Just x :: Maybe Bool

-- Without GADTs, we needed ExistentialQuantification for Eq to use
-- phantom types. Now we don't actually need it.

module SqlExpression where

import Data.Monoid ((<>))
import Data.Char (toLower)

data Expr a where
  I :: Int -> Expr Int
  B :: Bool -> Expr Bool
  C :: String -> Expr a
  Eq :: Eq a => Expr a -> Expr a -> Expr Bool

simplify :: Expr a -> Expr a
simplify expr@(Eq x y) =
  case eval expr of
    Just e -> B e
    Nothing -> Eq (simplify x) (simplify y)
simplify x = x

eval :: Expr a -> Maybe a
eval (C _) = Nothing
eval (B x) = Just x
eval (I x) = Just x
eval (Eq x y) = (==) <$> eval x <*> eval y

instance Show (Expr a) where
  show (I x) = show x
  show (B x) = map toLower $ show x
  show (C x) = show x
  show (Eq x y) = "(" <> show x <> " = " <> show y <> ")"

-- ghci> (Eq (C "user_id") (I 5))
-- ("user_id" = 5)

-- ghci> (Eq (B True) (I 5))

-- <interactive>:47:15-17: error:
--     • Couldn't match type ‘Int’ with ‘Bool’
--       Expected type: Expr Bool
--         Actual type: Expr Int
--     • In the second argument of ‘Eq’, namely ‘(I 5)’
--       In the expression: (Eq (B True) (I 5))
--       In an equation for ‘it’: it = (Eq (B True) (I 5))

-- ghci> simplify (Eq (B True) (B True))
-- true

-- ghci> simplify (Eq (I 5) (I 2))
-- false

-- ghci> simplify (Eq (C "user_id") (I 2))
-- ("user_id" = 2)

-- ghci> simplify (Eq (C "admin") (Eq (I 2) (I 5)))
-- ("admin" = false)
