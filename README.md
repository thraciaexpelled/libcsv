> [!WARNING]
> This library is unfinished. Please be patient.

# libcsv
C library for managing CSV files

This library can be used to write programs that preview spreadsheets or tables written in CSV.

New features will be in the works to provide more processing.

# Building
This library is buildable in all platforms, including *Squeaky-Shiny MS-DOS*™ on MINGW.

> [!NOTE]
> Source files in `deps/` are taken from the C package manager, [`clib`](https://www.github.com/clibs/clib)

If you have Docker, it is also possible to test the library in a containerized environment.

### To build the library
```commandline
$ make
```

### To package the binary in a folder
```commandline
$ make tidy
Forcibly removing any existing packages...
rm -rf libcsv-0.1.0-x86_64-linux-gcc

Building package structure...
Creating libcsv-0.1.0-x86_64-linux-gcc/lib
Creating libcsv-0.1.0-x86_64-...
```

### To install the package
```commandline
$ make install
```

### To test the package in a containerized environment
```commandline
$ docker build .

...

$ docker run -it <name_of_built_container>:<xxxxxxx> /bin/bash
root@blah:/# cd libcsv

# FOLLOW FIRST THREE STEPS

root@blah:/# cd ~/x
root@blah:~/x# gcc x.c -o x -lcsv
```
