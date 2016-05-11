INSTALL_DIR = /usr/local/bin

SCRIPT=pmc-img-gen.sh pmc-img-mod.sh pmc-ecc-flash-block-gen.sh

all:
	make -C pmc-crc32 all
	make -C pmc-csv2mem all
	make -C pmc-ecc all

clean:
	make -C pmc-crc32 clean
	make -C pmc-csv2mem clean
	make -C pmc-ecc clean


install: all
	mkdir -p $(INSTALL_DIR)
	list='$(SCRIPT)'; for file in $$list; do \
	     install -m 755 $$file $(INSTALL_DIR); \
	     done
	make -C pmc-crc32 install
	make -C pmc-csv2mem install
	make -C pmc-ecc install

uninstall:
	make -C pmc-crc32 uninstall
	make -C pmc-csv2mem uninstall
	make -C pmc-ecc uninstall
	list='$(SCRIPT)'; for file in $$list; do \
	     $(RM) $(INSTALL_DIR)/$$file; \
	     done

