.PHONY: clean

LIBS = -lmikey
CFLAGS = -Wall -Wextra -pedantic -std=c99
OBJECTS = addone.o

all: test

test: test.c $(OBJECTS)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

clean:
	rm -f test
	rm -f *.o
