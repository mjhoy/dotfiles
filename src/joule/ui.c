#include "global.h"
#include "common.h"
#include "ui.h"


void clear_screen()
{
    /* clear the screen */
    write(STDOUT_FILENO, "\x1b[2J", 4);

    /* reposition cursor to top left */
    write(STDERR_FILENO, "\x1b[H", 3);
}

void editor_draw_rows()
{
    int y;
    for (y = 0; y < E.screenrows; y++) {
        write(STDOUT_FILENO, "~", 1);

        if (y < E.screenrows - 1) {
            write(STDOUT_FILENO, "\r\n", 2);
        }
    }
}

void editor_refresh_screen()
{
    clear_screen();
    editor_draw_rows();
}

