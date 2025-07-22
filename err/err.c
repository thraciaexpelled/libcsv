// mute annoying unncesessary warnings
#ifdef __clang__
	#pragma clang diagnostic push
	#pragma clang diagnostic ignored "-Wincompatible-pointer-types-discards-qualifiers"
	#pragma clang diagnostic ignored "-Wstrict-prototypes"
	#pragma clang diagnostic ignored "-Wnewline-eof"
	#pragma clang diagnostic ignored "-Wsometimes-uninitialized"
	#pragma clang diagnostic ignored "-Wunused-variable"
    #pragma clang diagnostic ignored "-Wunused-but-set-variable"
    #pragma clang diagnostic ignored "-Wvoid-pointer-to-int-cast"
#endif

#include <assert.h>
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
            fprintf(stderr, "libcsv: internal error: invalid severity level\n");
            abort();
        }
    }
}



void err_out(Severity s, const char *msg, int __errno) {
    const char *errno_msg;

    if (__errno != (int)NULL) {
        errno_msg = strdup(strerror(__errno));
    } else {
        errno_msg = "(errno not provided)";
    }

    bool stfu = false;

    if (stfu) {
        // TODO: make this cross-plaform
        FILE *null = fopen("/dev/null", "a");
        assert(null != NULL);

        fprintf(null, "%s: %s: %s\n", return_errmsg_prefix(s), msg, strerror(__errno));

        if (s == Panic) abort();
        return;
    }

    if (s == Panic) {
        fprintf(stderr, "%s: %s: %s\n", return_errmsg_prefix(s), msg, strerror(__errno));
        abort();
    }

    fprintf(stderr, "%s: %s: %s\n", return_errmsg_prefix(s), msg, strerror(__errno));
}

#ifdef __clang__
	#pragma clang diagnostic pop
#endif
