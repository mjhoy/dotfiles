.PHONY: clean

LIBS = -lmikey
CFLAGS = -O

hello_world: hello_world.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

clean:
	rm -f *.o
	rm -f hello_world
