.PHONY: clean

LIBS = -lmikey
CFLAGS = -Wall -Wextra -pedantic -std=c99

all: atomic atomic_optimized

atomic: atomic.c
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

# Compile with -O2
atomic_optimized: atomic.c
	$(CC) -O2 -o $@ $^ $(CFLAGS) $(LIBS)

clean:
	rm -f atomic
	rm -f atomic_optimized
	rm -f *.o
