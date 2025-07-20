#define LIBCSV_VER "0.1.0"

typedef enum {
    Output,
    Info,
    Note,
    Important,
    Warning,
    Critical,
    Panic,
} Severity;

void err_out(Severity s, const char *msg, int __errno);