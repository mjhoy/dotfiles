.PHONY: clean

LIBS = -lmikey
CFLAGS = -O -Wall -Wextra -pedantic -std=c99

vfork: vfork.c
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

clean:
	rm -f vfork
	rm -f *.o
