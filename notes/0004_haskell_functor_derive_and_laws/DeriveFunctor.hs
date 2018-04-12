{-# LANGUAGE DeriveFunctor #-}

module DeriveFunctor where

data Simple a = S Int a
  deriving (Show, Eq, Functor)

data Tree a = Tip a | Fork (Tree a) (Tree a)
  deriving (Show, Eq, Functor)
