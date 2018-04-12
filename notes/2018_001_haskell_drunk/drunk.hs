{-# LANGUAGE GADTs, DataKinds, KindSignatures #-}

-- Dipping a toe into GADTs.
-- (It is bad to be drunk at compile time.)

module Main where

data Sobriety = Sober | Drunk
  deriving (Show)

data Driver (a :: Sobriety) where
  Alice :: Driver 'Sober
  Bob :: Driver 'Drunk

drive :: Driver 'Sober -> String
drive Alice = "Driving with Alice. We're safe!"

main :: IO ()
main = do
  print $ drive Alice

  -- This line doesn't type check:
  -- print $ drive Bob

  --  drunk.hs:18:17-19: error:
  --     • Couldn't match type ‘'Drunk’ with ‘'Sober’
  --       Expected type: Driver 'Sober
  --         Actual type: Driver 'Drunk
  --     • In the first argument of ‘drive’, namely ‘Bob’
  --       In the second argument of ‘($)’, namely ‘drive Bob’
  --       In a stmt of a 'do' block: print $ drive Bob

