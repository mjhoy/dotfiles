SHELL := bash

.PHONY: clean test

all: foo

foo: foo.c
	$(CC) -o $@ $^ -lmikey

# A simple way to test expected output.
test: foo
	@diff <(echo "Hello, Mikey!") <(./foo Mikey)
	@diff <(echo "Hello, nil!") <(./foo nil)
	@echo "Tests pass"

clean:
	rm -rf *.o
	rm -rf foo
