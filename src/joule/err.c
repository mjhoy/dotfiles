#include <stdio.h>
#include <stdlib.h>
#include "ui.h"
#include "err.h"

void die(const char *s)
{
    clear_screen();

    perror(s);
    exit(EXIT_FAILURE);
}
