.PHONY: update-submodules install install-linux

update-submodules:
	git submodule update --init

install:
	sh scripts/install-dotfiles.sh

install-linux:
	sh scripts/install-dotfiles.sh
	sh scripts/install-dotfiles-linux.sh
