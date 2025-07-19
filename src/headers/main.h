typedef struct {
    char *head;
    char *tail;
} CSV;

#ifndef LIBCSV_IMPL
#define LIBCSV_IMPL

CSV *libcsv_load_file(const char *filename);

const char **libcsv_get_topmost_row(CSV *csv);
const char **libcsv_get_everything(CSV *csv);

#endif // LIBCSV_IMPL