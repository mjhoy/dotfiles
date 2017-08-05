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
    return c;
}

void editor_process_keypress()
{
    char c = editor_read_key();
    switch (c) {
    case CTRL_KEY('q'):
        clear_screen();
        exit(EXIT_SUCCESS);
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
    if (get_window_size(&E.screenrows,
                        &E.screencols) == -1)
        die("get_window_size");
}

/* a simple text editor. */
int main()
{
    enable_raw_mode();

    while (1) {
        editor_refresh_screen();
        editor_process_keypress();
    }

    return EXIT_SUCCESS;
}
