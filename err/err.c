#include <errno.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "err.h"

static const char *return_errmsg_prefix(Severity s) {
    switch (s) {
        case Output:    return "[out]";
        case Info:      return "[info]";
        case Note:      return "[note]";
        case Important: return "[important]";
        case Warning:   return "[warning]";
        case Critical:  return "[critical]";
        case Panic:     return "[PANIC]";
        default: {
            fprintf(stderr, "libcsv: internal error: invalid severity level: %s", s);
            abort();
        }
    }
}

void err_out(Severity s, const char *msg, int errno) {
    const char *errno_msg;
    if (errno != NULL) {
        errno_msg = strdup(strerror(errno));
    } else {
        errno_msg = "(errno not provided)";
    }


}