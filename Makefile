.PHONY: install install-linux test

install:
	sh scripts/install-dotfiles.sh

install-linux:
	sh scripts/install-dotfiles.sh
	sh scripts/install-dotfiles-linux.sh

test:
	emacs --batch \
		-L emacs.d/lisp \
		-L emacs.d/lisp/init-org \
		-l init-org/captures-test.el \
		-f ert-run-tests-batch-and-exit
	emacs --batch \
		-l ert \
		-l emacs.d/test/org-query/org-query-test.el \
		-f ert-run-tests-batch-and-exit
