#include <sys/ioctl.h>
#include "global.h"
#include "common.h"
#include "ui.h"
#include "raw.h"

char editor_read_key()
{
    int nread;
    char c;
    while ((nread = read(STDIN_FILENO, &c, 1)) != 1) {
        if (nread == -1 &&
            errno != EAGAIN)
            die("read");
    }

    /* escape sequences */
    if (c == '\x1b') {
        char seq[3];

        if (read(STDIN_FILENO, &seq[0], 1) != 1) return '\x1b';
        if (read(STDIN_FILENO, &seq[1], 1) != 1) return '\x1b';

        if (seq[0] == '[') {
            switch (seq[1]) {
            case 'A': return CTRL_KEY('p');
            case 'B': return CTRL_KEY('n');
            case 'C': return CTRL_KEY('f');
            case 'D': return CTRL_KEY('b');
            }
        }
    }
    return c;
}

void editor_move_cursor(char key)
{
    switch (key) {
    case CTRL_KEY('n'):
        E.cy++;
        break;
    case CTRL_KEY('p'):
        E.cy--;
        break;
    case CTRL_KEY('f'):
        E.cx++;
        break;
    case CTRL_KEY('b'):
        E.cx--;
        break;
    case CTRL_KEY('a'):
        E.cx = 0;
        break;
    case CTRL_KEY('e'):
        E.cx = E.screencols;
        break;
    }
}

void editor_process_keypress()
{
    char c = editor_read_key();
    switch (c) {
    case CTRL_KEY('q'):
        clear_screen();
        exit(EXIT_SUCCESS);
        break;
    case CTRL_KEY('n'):
    case CTRL_KEY('p'):
    case CTRL_KEY('f'):
    case CTRL_KEY('b'):
    case CTRL_KEY('a'):
    case CTRL_KEY('e'):
        editor_move_cursor(c);
        break;
    }
}

int get_window_size(int *rows, int *cols)
{
    struct winsize ws;

    if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws) == -1 ||
        ws.ws_col == 0) {
        return -1;
    } else {
        *cols = ws.ws_col;
        *rows = ws.ws_row;
        return 0;
    }
}

void init_editor()
{
    E.cx = 0;
    E.cy = 0;
    if (get_window_size(&E.screenrows,
                        &E.screencols) == -1)
        die("get_window_size");
}

/* a simple text editor. */
int main()
{
    enable_raw_mode();
    init_editor();

    while (1) {
        editor_refresh_screen();
        editor_process_keypress();
    }

    return EXIT_SUCCESS;
}
