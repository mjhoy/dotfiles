TARGETS := all clean
SUBDIRS := $(wildcard */.)

# This is a simple Makefile that, for all subdirectories, runs `make
# all` and `make test` and `make clean`. When running tests, if
# successful, it prints "All tests pass!"
#
# Eventually I want every "note" file to have a Makefile, and set up a
# simple top level recursive make script for running tests and
# building all of them etc.

$(TARGETS): $(SUBDIRS)

# Special case `test` to print some output after running.
test: $(SUBDIRS)
	@echo "*** All tests pass! ***"

# "Make will set the special variable MAKECMDGOALS to the list of
# goals you specified on the command line." Use this to pass the top
# level goal to recursive calls to make.
$(SUBDIRS):
	@echo $@
	@$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: $(TARGETS) $(SUBDIRS)
