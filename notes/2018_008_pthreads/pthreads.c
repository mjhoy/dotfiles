#include <mikey/common.h>
#include <pthread.h>

/* Pointer fun. */

/* Allocates and returns a pointer to the result of adding one to the
 * number at pointer `arg`. Also while it's at, adds two to arg, why
 * not? */
int *
addOne(int *arg)
{
    int *p = malloc(sizeof(int));
    *p = *arg + 1;
    *arg = *arg + 2;
    return p;
}

int
main()
{
    pthread_t t1;
    void *res;
    int s;
    int b = 7;

    /* pthread API requires void pointers, so: */
    s = pthread_create(&t1,
                       NULL,
                       (void *(*) (void *)) addOne, /* cast addOne as function taking a void*, returning a void* */
                       (void *) &b                  /* cast param as a void * */
        );

    if (s != 0)
        err_exit_en(s, "pthread_create");

    printf("Main after thread.\n");
    printf("b is: %d\n", b);

    s = pthread_join(t1, &res);

    if (s != 0)
        err_exit_en(s, "pthread_join");

    printf("Thread returned %d\n", (int) *(int *)res);

    /* b is on the stack, but our thread can change it. */
    printf("b is now: %d\n", b);

    free(res);

    exit(EXIT_SUCCESS);

}
