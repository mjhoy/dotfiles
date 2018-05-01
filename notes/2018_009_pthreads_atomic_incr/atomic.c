#include <pthread.h>
#include <mikey/common.h>

static volatile int foo = 0;
static          int bar = 0;

static void *
incr(void *arg)
{
    int loops = *((int *) arg);
    int i;

    for (i = 0; i < loops; i++) {

       /* foo is volatile, meaning the compiler prevents optimizations on
        * arithmetic operations on it. I think.
        *
        * That said when I output asm with `clang -S` I don't see any
        * difference in the operations on foo or bar:
        *
        *  movl	_foo(%rip), %eax
        *  addl	$1, %eax
        *  movl	%eax, _foo(%rip)
        *  movl	_bar(%rip), %eax
        *  addl	$1, %eax
        *  movl	%eax, _bar(%rip)
        *
        *
        * There IS a difference when I compile with -O2 which is
        * interesting, clang breaks the loop into groups of 4
        * additions at once:
        *
        *  incl	_foo(%rip)
        *  incl	_foo(%rip)
        *  incl	_foo(%rip)
        *  incl	_foo(%rip)
        *  addl	$4, %eax
        *  movl	%eax, _bar(%rip)
        *  addl	$4, %edx
        *
        * */

        foo++;
        bar++;
    }

    return NULL;
}

int
main(int argc, char *argv[])
{
    pthread_t t1, t2, t3;

    int loops, s;

    loops = (argc > 1) ? get_int(argv[1], GN_GT_0, "num-loops") : 10000000;

    /* Create three threads to run `incr`. */
    s = pthread_create(&t1, NULL, incr, &loops);
    if (s != 0)
        err_exit_en(s, "pthread_create");
    s = pthread_create(&t2, NULL, incr, &loops);
    if (s != 0)
        err_exit_en(s, "pthread_create");
    s = pthread_create(&t3, NULL, incr, &loops);
    if (s != 0)
        err_exit_en(s, "pthread_create");

    s = pthread_join(t1, NULL);
    if (s != 0)
        err_exit_en(s, "pthread_join");
    s = pthread_join(t2, NULL);
    if (s != 0)
        err_exit_en(s, "pthread_join");
    s = pthread_join(t3, NULL);
    if (s != 0)
        err_exit_en(s, "pthread_join");

    printf("foo: %d\n", foo);
    printf("bar: %d\n", bar);

    /* Without optimizations:
     *
     * ./atomic
     *   foo: 13905792
     *   bar: 13861483
     *
     * (Both numbers are somewhat random, above the loop value.)
     *
     * With optimizations:
     *
     *   foo: 21084746
     *   bar: 10012692
     *
     * Again random, but bar is much closer to `loop` and occasionally
     * is just the value of loop.
     *
     * You can see above `bar` is incremented by 4 all at once, while
     * foo has four `incl` instructions in a row. incl is not atomic,
     * nor is addl, because they are actually composed of three
     * operations, a move into a register, then an add, then a move
     * back.
     * */
    exit(EXIT_SUCCESS);
}
