OBJECTS = raw.o err.o ui.o

.PHONY: clean

joule: main.c $(OBJECTS)
	$(CC) $(OBJECTS) main.c -o joule -Wall -Wextra -pedantic -std=c99

clean:
	rm -f joule
	rm -f *.o
