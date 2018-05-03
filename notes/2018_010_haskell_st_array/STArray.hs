module Main where

import Control.Monad (forM_, when)
import Data.Array.ST (newArray, readArray, writeArray, runSTUArray)
import Data.Array.Unboxed (UArray, (!), (//), array)
import Data.Int (Int64)
import Data.List (foldl')
import Data.Monoid ((<>))
import System.Environment (getArgs, getProgName)
import Safe (readMay)

-- A very simple example of mutable arrays in Haskell. The actual
-- implementation of the Fibonacci sequence is horribly broken b/c of
-- integer overflow (i.e. WRONG actual answers below), but you get the
-- idea:

-- (Constructs an array that is 80000 elements, calculating index j+1
-- by adding index j and j-1, starting with [0,1], in an imperative
-- fashion, then returns index 80000)

-- time ./starray fast 80000
-- Fib @ 80000: 9144286319190334149
--   real	0m0.067s
--   user	0m0.054s
--   sys	0m0.007s

-- time ./starray slow 80000
--   Fib @ 80000: 9144286319190334149
--   real	0m2.041s
--   user	0m1.976s
--   sys	0m0.060s


-- Uses STUArray to build up an array by mutating one array in memory
-- (just using fib sequence for example)
fastArray :: Int -> UArray Int Int64
fastArray n = runSTUArray $ do
  arr <- newArray (0, n) 0
  when (n > 0) $ do
    writeArray arr 1 1
    forM_ [1..(n - 1)] $ \j -> do
      prev <- readArray arr (j - 1)
      curr <- readArray arr j
      writeArray arr (j + 1) (prev + curr)
  pure arr

-- Uses the standard Array machinery, in a "pure" fashion, meaning no
-- mutation and every update means the array is copied.
slowArray :: Int -> UArray Int Int64
slowArray n = foldl' iter initialArray [1..(n - 1)]
  where
    iter :: UArray Int Int64 -> Int -> UArray Int Int64
    iter arr j = arr // [(j + 1, next)]
      where
        prev = arr ! (j - 1)
        curr = arr ! j
        next = prev + curr
    initialArray :: UArray Int Int64
    initialArray = array (0, n + 1) [(0,0), (1,1), (2, 1)]


main :: IO ()
main = do
  progName <- getProgName
  args <- getArgs

  let run :: (Int -> UArray Int Int64) -> Maybe Int -> IO ()
      run _ Nothing = usage progName
      run fn (Just i) = do
        let arr = fn i
            lastNum = arr ! i
        putStrLn $ "Fib @ " <> show i <> ": " <> show lastNum

  case args of
    ("slow":n:_) -> run slowArray (readMay n)
    ("fast":n:_) -> run fastArray (readMay n)
    _ -> usage progName

  where

    usage :: String -> IO ()
    usage prog = putStrLn $ "usage: " <> prog <> " [fast|slow] INT "

