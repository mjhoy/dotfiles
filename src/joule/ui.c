#include "global.h"
#include "common.h"
#include "abuf.h"
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

void editor_draw_rows(struct abuf *ab)
{
    int y;
    for (y = 0; y < E.screenrows; y++) {
        ab_append(ab, "~", 1);

        if (y < E.screenrows - 1)
            ab_append(ab, "\r\n", 2);
    }
}

void editor_refresh_screen()
{
    struct abuf ab = ABUF_INIT;
    ab_append(&ab, "\x1b[2J", 4);
    ab_append(&ab, "\x1b[H", 3);
    editor_draw_rows(&ab);
    ab_append(&ab, "\x1b[H", 3);

    if (write(STDOUT_FILENO, ab.b, ab.len) == -1)
        die("write");
    ab_free(&ab);
}
