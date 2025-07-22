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

	@echo $(ECHOFLAGS) "\nBuilding package structure..."
	@echo $(ECHOFLAGS) "Creating $(BUILDDIR)/lib"
	@mkdir -p $(BUILDDIR)/lib

	@echo $(ECHOFLAGS) "Creating $(BUILDDIR)/include\n"
	@mkdir -p $(BUILDDIR)/include

	@echo $(ECHOFLAGS) "Copying files..."

	@# Copying compiled library
	cp $(BINNAMEINFLAG) $(BUILDDIR)/lib
	
	@# Copying include file
	cp $(SRCDIR)/headers/main.h $(BUILDDIR)/include
	mv $(BUILDDIR)/include/main.h $(BUILDDIR)/include/csv.h

	@echo $(ECHOFLAGS) "\nAll done\n"

clean:
	rm -f *.o
	rm -rf deps/*/*.o
	rm -f *$(BINFMT)
	rm -f $(BINNAME)
	rm -rf $(BUILDDIR)
	@echo

install: tidy
	cp -r $(BUILDDIR)/include/* $(PREFIX1)
	cp -r $(BUILDDIR)/lib/* $(PREFIX2)

ifeq "$(shell uname)" "Linux"
	@echo $(ECHOFLAGS) "\nLinux detected, some distributions of GNU/Linux may not find $(BINNAMEINFLAG) in our directories\n"
	ln -sf $(PREFIX1)/csv.h /usr/include/csv.h
	ln -sf $(PREFIX2)/$(BINNAMEINFLAG) /usr/lib/$(BINNAMEINFLAG)
endif

docker: clean
	@echo "Cleaning existing .tmp\n"
	rm -rf .tmp

	mkdir -p .tmp/libcsv
	cp -r -v ./* .tmp/libcsv
