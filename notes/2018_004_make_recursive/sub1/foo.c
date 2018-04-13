#include <mikey/common.h>

int main(int argc, char *argv[]) {
    if (argc < 2 || strcmp(argv[1], "--help") == 0)
        usage_err("%s name\n", argv[0]);

    char *name = argv[1];

    printf("Hello, %s!\n", name);

    exit(EXIT_SUCCESS);
}
