.PHONY: install install-linux

install:
	sh scripts/install-dotfiles.sh

install-linux:
	sh scripts/install-dotfiles.sh
	sh scripts/install-dotfiles-linux.sh
