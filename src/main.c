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


#define LIBCSV_IMPL

CSV *libcsv_load_file(const char *filename) {
	    
}
