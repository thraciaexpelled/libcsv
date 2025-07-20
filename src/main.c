// mute annoying unncesessary warnings
#ifdef __clang__
	#pragma clang diagnostic push
	#pragma clang diagnostic ignored "-Wincompatible-pointer-types-discards-qualifiers"
	#pragma clang diagnostic ignored "-Wstrict-prototypes"
	#pragma clang diagnostic ignored "-Wnewline-eof"
	#pragma clang diagnostic ignored "-Wsometimes-uninitialized"
	#pragma clang diagnostic ignored "-Wunused-variable"
#endif

#include <assert.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "./headers/main.h"

// erroneous
//#include <deps/strsplit/strsplit.h>

#include "../deps/strsplit/strsplit.h"

// erroneous
// #include <err/err.h>

#include "../err/err.h"

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

static int count_character(char ch, const char *str) {
	int length = strlen(str);
	int count = 0;
	
	for (int i = 0; i < length; ++i) {
		if (str[i] == ch) count++; 
	}

	return count;
}

#define LIBCSV_IMPL

CSV *libcsv_load_file(const char *filename) {
	CSV *csv = malloc((sizeof(CSV*)) + (sizeof(char*) * 2));
	if (csv == NULL) { err_out(Panic, "Cannot read file", errno); }

	const char *csv_file = read_file(filename);

	csv->head = strdup(get_csv_topmost_row(csv_file));
	csv->tail = strdup(get_csv_values(csv_file));

	return csv;
}

const char **libcsv_get_topmost_row(CSV *csv) {
    const char *topmost_row = strdup(csv->head);	
	int items_in_array = count_character(',', topmost_row);

	const char **the_topmost_row = malloc(sizeof(char**) * items_in_array);
	if (the_topmost_row == NULL) { err_out(Panic, "Unexpected error", errno); }

	size_t _ = strsplit(topmost_row, the_topmost_row, "\n");

	return the_topmost_row;
}

#ifdef __clang__
	#pragma clang diagnostic pop
#endif
