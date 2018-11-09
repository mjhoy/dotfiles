.PHONY: clean

LIBS = -lmikey
CFLAGS = -O

xxc: main.o
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

clean:
	rm -f *.o
	rf -f xxc
