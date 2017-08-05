#include "global.h"
#include "common.h"
#include "ui.h"


void clear_screen()
{
    /* clear the screen */
    if (write(STDOUT_FILENO, "\x1b[2J", 4) == -1)
        die("write");

    /* reposition cursor to top left */
    if (write(STDERR_FILENO, "\x1b[H", 3) == -1)
        die("write");
}

void editor_draw_rows()
{
    int y;
    for (y = 0; y < E.screenrows; y++) {
        if (write(STDOUT_FILENO, "~", 1) == -1)
            die("write");

        if (y < E.screenrows - 1) {
            if (write(STDOUT_FILENO, "\r\n", 2))
                die("write");
        }
    }
}

void editor_refresh_screen()
{
    clear_screen();
    editor_draw_rows();
}

