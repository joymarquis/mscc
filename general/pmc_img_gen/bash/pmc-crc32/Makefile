BIN = pmc-crc32
SCRIPT = pmc-crc32.sh
INSTALL_DIR = /usr/local/bin

CFLAGS += -Wall -g -static

all: $(BIN)

%: %.c
	$(CC) $(CFLAGS) -o $@ $^

clean:
	$(RM) $(BIN)


install: all
	mkdir -p $(INSTALL_DIR)
	list='$(BIN) $(SCRIPT)'; for file in $$list; do \
	     install -m 755 $$file $(INSTALL_DIR); \
	     done

uninstall:
	list='$(BIN) $(SCRIPT)'; for file in $$list; do \
	     $(RM) $(INSTALL_DIR)/$$file; \
	     done

