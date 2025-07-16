# Main Directories

## Source directory
SRCDIR = src/

## Include (header) directory
INCDIR = $(SRCDIR)headers/

# Post Compile Directories

## Binary name
BINNAME = libcsv

### Binary name used in compiler flags
BINNAMEINFLAG = libcsv$(shell ./makehelpers/friend_of_all_makefiles.sh return_dylib_file_format)

## Version
VERSION != ./makehelpers/friend_of_all_makefiles.sh return_version
MARCH != uname -m
MOS != ./makehelpers/friend_of_all_makefiles.sh return_enduser_os | tr -d " " | tr "[:upper:]" "[:lower:]"

## Build directory
BUILDDIR = $(BINNAME)-$(MARCH)-$(VERSION)-$(MOS)/

# Default Compiler
CC != ./makehelpers/friend_of_all_makefiles.sh return_optimal_compiler

## Compiler flags for default compiler
CCFLAGS = -Wall -Wextra -Wpedantic -O2 -march=native

### INCARG #1
CCFLAGS += -I$(INCDIR)

## Linker flags
LDFLAGS =