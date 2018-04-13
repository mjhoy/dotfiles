SHELL := bash

.PHONY: clean test

all: bar

bar: bar.c
	$(CC) -o $@ $^ -lmikey

# A simple way to test expected output.
test: bar
	@diff <(echo "Success") <(./bar 1)
	@diff <(echo "Success") <(./bar 10)
	@echo "Tests pass"

clean:
	rm -rf *.o
	rm -rf bar
