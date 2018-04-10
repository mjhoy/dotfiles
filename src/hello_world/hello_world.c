#include <stdio.h>
#include <mikey/common.h>
#include <mikey/error_functions.h>

/**
 * Example program.
 *
 * Install with `nix-env -iA nixpkgs.hello_world`.
 */

int main()
{
    if (write(STDOUT_FILENO, "Hello, world!\n", 14) < 0)
        err_exit("write");

    exit(EXIT_SUCCESS);
}
