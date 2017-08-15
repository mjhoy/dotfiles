.PHONY: clean

allgen: build/include/common.h \
	build/include/error_functions.h \
	build/include/get_num.h \
	build/lib/libmikey.a

build/include/common.h: common.h
	mkdir -p build/include
	cp common.h build/include/common.h
build/include/error_functions.h: error_functions.h
	mkdir -p build/include
	cp error_functions.h build/include/error_functions.h
build/include/get_num.h: get_num.h
	mkdir -p build/include
	cp get_num.h build/include/get_num.h
build/lib/libmikey.a: libmikey.a
	mkdir -p build/lib
	cp libmikey.a build/lib/libmikey.a

libmikey.a: *.c ename.c.inc
	${CC} -c -g ${CFLAGS} *.c
	${RM} libmikey.a
	${AR} rs libmikey.a *.o

ename.c.inc:
	sh Build_ename.sh > ename.c.inc

clean:
	rm -f *.o ename.c.inc libmikey.a
	rm -rf build
