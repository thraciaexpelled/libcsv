# Main Directories

## Source directory
SRCDIR = src

## Include (header) directory
INCDIR = $(SRCDIR)/headers

# Post Compile Directories

## Binary name
BINNAME = libcsv

### Binary format (default: .dylib, MUST change according to your OS)
BINFMT = .dylib

### Binary name used in compiler flags
BINNAMEINFLAG = $(BINNAME)$(BINFMT)

## Version
VERSION = 0.1.0
MARCH = $(shell uname -m)

## Build directory
BUILDDIR = $(BINNAME)-$(MARCH):$(VERSION)/

# Default Compiler (change to whatever you prefer)
CC = clang

## Compiler flags for default compiler
CCFLAGS = -Wall -Wextra -Wpedantic -O2 -march=native

### INCARG #1
CCFLAGS += -I$(INCDIR)

## Linker flags
LDFLAGS =