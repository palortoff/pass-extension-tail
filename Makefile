PREFIX ?= /usr
DESTDIR ?=
LIBDIR ?= $(PREFIX)/lib
SYSTEM_EXTENSION_DIR ?= $(LIBDIR)/password-store/extensions
MANDIR ?= $(PREFIX)/share/man
BASHCOMPDIR ?= /etc/bash_completion.d

all:
	@echo "pass-tail is a shell script and does not need compilation, it can be simply executed."
	@echo ""
	@echo "To install it try \"make install\" instead."
	@echo
	@echo "To run pass tail one needs to have some tools installed on the system:"
	@echo "     password store"
	@echo "     tail"

install:
	@install -v -d "$(DESTDIR)$(MANDIR)/man1"
	@install -v -m 0644 man/pass-extension-tail.1 "$(DESTDIR)$(MANDIR)/man1/pass-tail.1"
	@install -v -d "$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/"
	@install -v -m0755 src/tail.bash "$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/tail.bash"
	@install -v -m0755 src/tailedit.bash "$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/tailedit.bash"
	@install -v -m0755 src/tailclip.bash "$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/tailclip.bash"
	@install -v -d "$(DESTDIR)$(BASHCOMPDIR)/"
	@install -v -m 644 completion/pass-tail.bash.completion  "$(DESTDIR)$(BASHCOMPDIR)/pass-tail"
	@echo
	@echo "pass-tail is installed succesfully"
	@echo

uninstall:
	@rm -vrf \
		"$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/tail.bash" \
		"$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/tailedit.bash" \
		"$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/tailclip.bash" \
		"$(DESTDIR)$(MANDIR)/man1/pass-tail.1" \
		"$(DESTDIR)$(BASHCOMPDIR)/pass-tail"

lint:
	shellcheck -s bash src/tail.bash
	shellcheck -s bash src/tailedit.bash
	shellcheck -s bash src/tailclip.bash

.PHONY: install uninstall lint
