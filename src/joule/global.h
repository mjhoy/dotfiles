#ifndef _GLOBAL_H
#define _GLOBAL_H

#include "common.h"

struct editorConfig {
    int cx, cy;
    int screenrows;
    int screencols;
    struct termios orig_termios;
};

struct editorConfig E;

#endif
