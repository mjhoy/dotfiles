#ifndef _LIBMIKEY_ERROR_FUNCTIONS_H
#define _LIBMIKEY_ERROR_FUNCTIONS_H

void err_msg(const char *format, ...);

#ifdef __GNUC__

/* prevent `gcc -Wall` from complaining if these functions are used at
 * the end of a non-void function. */

#define NORETURN __attribute__ ((__noreturn__))
#else
#define NORETURN
#endif

void err_exit(const char *format, ...) NORETURN ;

/* like `err_exit`, but don't flush stdout, and calls _exit(2). */
void err__exit(const char *format, ...) NORETURN ;

void err_exit_en(int errnum, const char *format, ...) NORETURN ;

void fatal(const char *format, ...) NORETURN ;

void usage_err(const char *format, ...) NORETURN ;

void cmd_line_err(const char *format, ...) NORETURN ;

#endif
