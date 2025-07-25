# Main Directories

## Source directory
SRCDIR = src

## Include (header) directory
INCDIR = $(SRCDIR)/headers

## clib(1) dependencies directory
DEPSDIR = deps

## Error handling
ERRDIR = err

# Post Compile Directories

## Binary name
BINNAME = libcsv

### Binary format 
ifeq "$(shell uname)" "Darwin"
	BINFMT = .dylib
else ifeq "$(shell uname)" "MSYS"
	BINFMT = .dll
else
	BINFMT = .so
endif

# (Linux, FreeBSD, OpenBSD, etc.)
# BINFMT = .so

# (Squeaky-Shiny MS-DOS, Cross-Compilers on UNIX-like systems, etc.)
# BINFMT = .dll

### Binary name used in compiler flags
BINNAMEINFLAG = $(BINNAME)$(BINFMT)

## Version
VERSION = 0.9.0
MARCH = $(shell uname -m)
SYSTEM = $(shell uname | tr [:upper:] [:lower:])

## Build directory (makes following directory name - e.g. libcsv-1.0.0-i386-linux-gcc)
BUILDDIR = $(BINNAME)-$(VERSION)-$(MARCH)-$(SYSTEM)-$(CC)

## Prefix #1 -- C header
PREFIX1 = /usr/local/include

## Prefix #2 -- Dynamic object
PREFIX2 = /usr/local/lib

# Default Compiler (change to whatever you prefer)
CC = clang

## Compiler flags for default compiler
CCFLAGS = -Wall -Wextra -Wpedantic -O2 -march=native

### Linux needs this flag
ifeq "$(shell uname)" "Linux"
	CCFLAGS += -fPIC
endif

### INCARG #1
CCFLAGS += -I$(INCDIR)

### INCARG #2
CCFLAGS += -I$(DEPSDIR)*

### INCARG #3
CCFLAGS += -I$(ERRDIR)*

## Linker flags
LDFLAGS =

## I'm as embarassed to say that we need this, for
## proper echo output on GNU/Linux
ECHOFLAGS =

ifeq "$(shell uname)" "Linux"
	ECHOFLAGS += -e
endif
