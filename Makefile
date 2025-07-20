include config.mk

.PHONY: tidy clean install docker

CLIBSRC = $(wildcard deps/*/*.c)
CLIBOBJS = $(CLIBSRC:.c=.o)

OBJS = err.o

$(BINNAMEINFLAG): $(SRCDIR)/main.c $(CLIBOBJS) err.o
	$(CC) $(CCFLAGS) $< -shared -o $@ $(CLIBOBJS) $(OBJS)
	@echo "Run *make tidy* to package this library"

err.o: $(ERRDIR)/err.c
	$(CC) $(CCFLAGS) $< -c -o $@

%.o: %.c
	$(CC) $(CCFLAGS) $< -c -o $@

tidy:
	@echo "Forcibly removing any existing packages..."
	rm -rf $(BUILDDIR)

	@echo "\nBuilding package structure..."
	@echo "Creating $(BUILDDIR)/lib"
	@mkdir -p $(BUILDDIR)/lib

	@echo "Creating $(BUILDDIR)/include\n"
	@mkdir -p $(BUILDDIR)/include

	@echo "Copying files..."

	# Copying compiled library
	cp $(BINNAMEINFLAG) $(BUILDDIR)/lib
	# Copying include file
	cp $(SRCDIR)/headers/main.h $(BUILDDIR)/include
	mv $(BUILDDIR)/include/main.h $(BUILDDIR)/include/csv.h

	@echo "\nAll done\n"

clean:
	rm -f *.o
	rm -f *$(BINFMT)
	rm -f $(BINNAME)
	rm -rf $(BUILDDIR)

install:
	cp -r $(BUILDDIR)/include/* $(PREFIX1)
	cp -r $(BUILDDIR)/lib/* $(PREFIX2)

docker: clean
	@echo "Cleaning existing .tmp\n"
	rm -rf .tmp

	mkdir -p .tmp/libcsv
	cp -r -v ./* .tmp/libcsv