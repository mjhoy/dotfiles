#include <mikey/common.h>
#include <mikey/error_functions.h>

/**
 * xxc
 *
 * (sort of) like xxd, but operates on argv.
 */

int main(int argc, char *argv[])
{
    if (argc != 2 || strcmp(argv[1], "--help")) {
        usage_err("xxc <string>\n");
    }

    printf("wip...\n");
    exit(EXIT_SUCCESS);
}
