SHELL := bash

.PHONY: clean test

LIBS := -lmikey
CFLAGS := -O -Wall -Wextra -pedantic -std=c99

getsid: getsid.c
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

# I don't even know if this test *should* pass, but I believe OS X (at
# least 10.13) does something wrong: `ps -p $$ -o sess` always gives
# "0" as the output for session id.
test: getsid
	@diff <( ./getsid ) <( ps -p $$$$ -o sess )
	@echo "Test passed."

clean:
	rm -f getsid
	rm -f *.o
