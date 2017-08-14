#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <errno.h>
#include "get_num.h"

static void
gn_fail(const char *fname, const char *msg, const char *arg, const char *name)
{
    fprintf(stderr, "%s error", fname);
    if (name != NULL)
        fprintf(stderr, " in (%s)", name);
    fprintf(stderr, ": %s\n", msg);
    if (arg != NULL && *arg != '\0')
        fprintf(stderr, "       offending text: %s\n", arg);
    exit(EXIT_FAILURE);
}

static long
get_num(const char *fname, const char *arg, int flags, const char *name)
{
    long res;
    char *endptr;
    int base;

    if (arg == NULL || *arg == '\0')
        gn_fail(fname, "null or empty string", arg, name);

    base = (flags & GN_ANY_BASE) ? 0 :
        (flags & GN_BASE_8) ? 8 :
        (flags & GN_BASE_16) ? 16 : 10;

    errno = 0;

    res = strtol(arg, &endptr, base);
    if (errno != 0)
        gn_fail(fname, "strtol() failed", arg, name);

    if (*endptr != '\0')
        gn_fail(fname, "nonumeric characters", arg, name);

    if ((flags & GN_NONNEG) && res < 0)
        gn_fail(fname, "negative value not allowed", arg, name);

    if ((flags & GN_GT_0) && res <= 0)
        gn_fail(fname, "value must be > 0", arg, name);

    return res;
}

long
get_long(const char *arg, int flags, const char *name)
{
    return get_num("get_long", arg, flags, name);
}

int
get_int(const char *arg, int flags, const char *name)
{
    long res;
    res = get_num("get_int", arg, flags, name);
    if (res > INT_MAX || res < INT_MIN)
        gn_fail("get_int", "integer out of range", arg, name);

    return (int) res;
}
