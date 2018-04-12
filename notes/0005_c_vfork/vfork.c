#include <mikey/common.h>
#include <mikey/error_functions.h>

int main() {

    int foo = 5;

    switch (vfork()) {
    case -1:
        err_exit("vfork");

    case 0:
        /* vfork() means that the parent suspends and the child
         * executes first.
         *
         * We SHOULD be executing in the parent's memory space,
         * without making a copy like with fork(). */

        write(STDOUT_FILENO, "Child executing\n", 16);

        foo += 3;               /* Manipulate the stack. */

        /* aside: because of resource sharing, vfork should always
         * call _exit() instead of exit() so as not clobber the
         * parent's resources and call atexit handlers twice and so
         * on. i think this applies to fork() without an exec call
         * too.*/
        _exit(EXIT_SUCCESS);

    default:
        write(STDOUT_FILENO, "Parent executing\n", 17);

        printf("Foo is now: %d\n", foo);
        exit(EXIT_SUCCESS);

        /* We *should* get, "Foo is now: 8". But, on OS X 10.13, I
         * get:
         *
         * $ ./vfork
         * Child executing
         * Parent executing
         * Foo is now: 5
         *
         * So it seems vfork is acting like fork? Or I'm
         * misunderstanding something.
         * */
    }
}
