#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "./headers/main.h"


static const char *read_file(const char *filename) {
	FILE *fptr = fopen(filename, "r");
	assert(fptr != NULL);

	char *buffer = 0;
	long buflen;

	fseek(fptr, 0, SEEK_END);
	buflen = ftell(fptr);
	fseek(fptr, 0, SEEK_SET);

	buffer = malloc(buflen);
	assert(buffer != NULL);
	
	fread(buffer, 1, buflen, fptr);
	fclose(fptr);

	return buffer;
}

// Excerpt from the remnants of the halted `csv-view`

// --! WARNING! Vibe Coded!!! (using duck.ai) !--

static char *get_csv_topmost_row(const char *csvData) {
    size_t len = strcspn(csvData, "\n");
    char *retval = (char *)malloc((len + 1) * sizeof(char));
    assert(retval != NULL);

    strncpy(retval, csvData, len);
    retval[len] = '\0'; // Ensure null termination

    return retval;
}

static char *get_csv_values(const char *csvData) {
    const char *newline_pos = strchr(csvData, '\n');

    if (newline_pos == NULL) {
        char *empty_string = strdup("");
        assert(empty_string != NULL);
        return empty_string;
    }

    char *retval = strdup(newline_pos + 1);
    assert(retval != NULL);

    return retval;
}

// --! End of Vibe Coding !--


#define LIBCSV_IMPL

CSV *libcsv_load_file(const char *filename) {
	CSV *csv = malloc((sizeof(CSV*)) + (sizeof(char*) * 2));
	assert(csv != NULL);

	const char *csv_file = read_file(filename);

	csv->head = strdup(get_csv_topmost_row(csv_file));
	csv->tail = strdup(get_csv_values(csv_file));

	return csv;
}