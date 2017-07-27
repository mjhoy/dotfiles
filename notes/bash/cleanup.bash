#!/bin/bash

# stop execution on error
set -e

cleanup() {
  echo "baz"
}

# run the cleanup function at exit
trap cleanup 0

echo "foo"
false # error; exits here
echo "bar"


# $ bash cleanup.bash
# foo
# baz
