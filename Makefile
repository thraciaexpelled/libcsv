include config.mk

.PHONY: tidy clean install docker

$(BINNAMEINFLAG): $(SRCDIR)/main.c
	$(CC) $(CCFLAGS) $< -shared -o $@
	@echo "Run *make tidy* to package this library"

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
	cp -r $(BUILDDIR)/include/* /usr/local/include
	cp -r $(BUILDDIR)/lib/* /usr/local/lib

docker: clean
	mkdir -p .tmp/libcsv
	cp -r -v ./* .tmp/libcsv