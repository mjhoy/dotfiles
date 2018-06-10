#include <stdio.h>
#include <mikey/common.h>
#include "addone.h"

static char* TESTING = "This is a static string.\n";

int main()
{
    printf("Foo.\n");
    printf("%s", TESTING);
    printf("One plus two is: %d", addone(2));
    return EXIT_SUCCESS;
}
