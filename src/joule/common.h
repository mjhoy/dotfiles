#ifndef _COMMON_H
#define _COMMON_H

#include <stdlib.h>
#include <unistd.h>
#include <ctype.h>
#include <stdio.h>
#include <errno.h>
#include <termios.h>

#include "err.h"

#define CTRL_KEY(k) ((k) & 0x1f)

#endif
