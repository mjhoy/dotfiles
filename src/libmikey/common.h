#ifndef _LIBMIKEY_COMMON_H
#define _LIBMIKEY_COMMON_H

/* type definitions */
#include <sys/types.h>

/* i/o */
#include <stdio.h>

/* library functions */
#include <stdlib.h>

/* system calls */
#include <unistd.h>

/* declares errno */
#include <errno.h>

/* string handling */
#include <string.h>

#include "get_num.h"
#include "error_functions.h"

typedef enum { FALSE, TRUE } Boolean;
#define min(m,n) ((m) < (n) ? (m) : (n))
#define max(m,n) ((m) > (n) ? (m) : (n))

#endif
