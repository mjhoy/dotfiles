{-# LANGUAGE GADTs, DataKinds, KindSignatures #-}

module Main where

data Sobriety = Sober | Drunk
data Driver (a :: Sobriety) where
  Alice :: Driver 'Sober
  Bob :: Driver 'Drunk

main = print "foo"
