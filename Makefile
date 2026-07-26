.PHONY: install install-linux test

install:
	bash scripts/install-dotfiles.sh

install-linux:
	bash scripts/install-dotfiles.sh
	bash scripts/install-dotfiles-linux.sh

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
