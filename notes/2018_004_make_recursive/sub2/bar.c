#include <mikey/common.h>

int main(int argc, char *argv[]) {
    if (argc < 2 || strcmp(argv[1], "--help") == 0)
        usage_err("%s n \nwhere n compared to _SC_LOGIN_NAME_MAX.\n", argv[0]);

    int n = get_int(argv[1], GN_NONNEG, "n");

    long lim;

    lim = sysconf(_SC_LOGIN_NAME_MAX);

    if (lim != -1) {

        if (n > lim) {
            fatal("%d is greater than limit %ld\n", n, lim);
        } else {
            printf("Success\n");
            exit(EXIT_SUCCESS);
        }

    } else {
        if (errno == 0) {
            fatal("limit indeterminate");
        } else {
            err_exit("sysconf _SC_LOGIN_NAME_MAX");
        }
    }

    printf("Hello, %d!\n", n);

    exit(EXIT_SUCCESS);
}
