INSTALL_DIR = /usr/local/bin

SCRIPT = pmc-csv2mem.sh

all:

clean:


install: all
	mkdir -p $(INSTALL_DIR)
	list='$(SCRIPT)'; for file in $$list; do \
	     install -m 755 $$file $(INSTALL_DIR); \
	     done

uninstall:
	list='$(SCRIPT)'; for file in $$list; do \
	     $(RM) $(INSTALL_DIR)/$$file; \
	     done

