#include <string.h>
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

        if (y == (E.screenrows / 3)) {
            char welcome[80];
            int welcomelen =
                snprintf(welcome, sizeof(welcome),
                         "Joule editor -- version %s", JOULE_VERSION);
            int padding = (E.screencols - welcomelen) / 2;
            if (padding) {
                ab_append(ab, "~", 1);
                padding--;
            }
            while (padding--) ab_append(ab, " ", 1);
            if (welcomelen > E.screencols) welcomelen = E.screencols;
            ab_append(ab, welcome, welcomelen);
        } else {
            ab_append(ab, "~", 1);
        }

        ab_append(ab, "\x1b[K", 3); /* clear line to right of the cursor */
        if (y < E.screenrows - 1)
            ab_append(ab, "\r\n", 2);
    }
}

void editor_refresh_screen()
{
    struct abuf ab = ABUF_INIT;

    ab_append(&ab, "\x1b[?25l", 6); /* hide cursor */
    ab_append(&ab, "\x1b[H", 3);

    editor_draw_rows(&ab);

    /* draw cursor at current x,y */
    char buf[32];
    snprintf(buf, sizeof(buf), "\x1b[%d;%dH", E.cy + 1, E.cx + 1);
    ab_append(&ab, buf, strlen(buf));
    ab_append(&ab, "\x1b[?25h", 6); /* show cursor */

    if (write(STDOUT_FILENO, ab.b, ab.len) == -1)
        die("write");
    ab_free(&ab);
}
