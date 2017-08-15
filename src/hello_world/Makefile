.PHONY: clean

LIBS = -static -lmikey
CFLAGS = ${include_dirs} -O
include_dirs = -I${libmikey}/include

hello_world: hello_world.o
	$(CC) -o $@ $^ $(CFLAGS) $(libmikey)/lib/libmikey.a

clean:
	rm -f *.o
	rm -f hello_world
