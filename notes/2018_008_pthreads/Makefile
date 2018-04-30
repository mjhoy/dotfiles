.PHONY: clean

LIBS = -lmikey
CFLAGS = -O -Wall -Wextra -pedantic -std=c99

pthreads: pthreads.c
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

clean:
	rm -f pthreads
	rm -f *.o
