include config.mk

.PHONY: tidy clean install

$(BINNAMEINFLAG): $(SRCDIR)/main.c
	$(CC) $(CCFLAGS) $< -shared -o $@
	@echo "Run *make tidy* to package this library"

tidy: $(BUILDDIR)
	python3 ./utils/janitor.py $(BUILDDIR)

clean:
	rm -f *.o
	rm -f *$(BINFMT)
	rm -f $(BINNAME)

install:
	@echo "Not implemented yet"