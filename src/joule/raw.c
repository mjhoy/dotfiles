#include "common.h"
#include "global.h"
#include "raw.h"

void disable_raw_mode()
{
    if (tcsetattr(STDIN_FILENO, TCSAFLUSH, &E.orig_termios) == -1)
        die("tcsetattr");
}

void enable_raw_mode()
{
    if (tcgetattr(STDIN_FILENO, &E.orig_termios) == -1)
        die("tcgetattr");

    atexit(disable_raw_mode);

    struct termios raw = E.orig_termios;

    raw.c_iflag &= ~( IXON      /* disable Ctrl-S/Ctrl-Q */
                    | ICRNL     /* Fix Ctrl-M */
                    | BRKINT
                    | INPCK
                    | ISTRIP
                    );
    raw.c_lflag &=
        ~( ECHO                 /* turn off echo */
         | ICANON               /* turn off canonical mode: read byte-by-byte */
         | ISIG                 /* disable Ctrl-C/Ctrl-Z signals */
         | IEXTEN               /* disable Ctrl-V */
         );

    raw.c_oflag &= ~(OPOST);    /* Don't translate newlinesm */

    raw.c_cflag |= (CS8);

    raw.c_cc[VMIN] = 0;         /* min bytes to read */
    raw.c_cc[VTIME] = 1;        /* time to wait in 1/10 seconds */

    if (tcsetattr(STDIN_FILENO, TCSAFLUSH, &raw) == -1)
        die("tcsetattr");
}
