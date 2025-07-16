#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef LIBCSV_IMPL
#define LIBCSV_IMPL

void libcsv_greet(const char *user) {
	printf("Hello, %s\n", user);
}

#endif // LIBCSV_IMPL