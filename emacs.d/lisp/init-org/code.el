(setq org-confirm-babel-evaluate nil)

(require 'ob-sh)
; do I want 'ob-shell ?

(require 'ob-sql)

;; fontify our code blocks
(setq org-src-fontify-natively t)

;; edit src in the current window
(setq org-src-window-setup 'current-window)

;; structure shortcuts
(add-to-list 'org-structure-template-alist
             '("hs" "#+BEGIN_SRC haskell\n?\n#+END_SRC" "<src lang=\"haskell\">\n?\n</src>"))
(add-to-list 'org-structure-template-alist
             '("rs" "#+BEGIN_SRC rust\n?\n#+END_SRC" "<src lang=\"rust\">\n?\n</src>"))
(add-to-list 'org-structure-template-alist
             '("sh" "#+BEGIN_SRC shell\n?\n#+END_SRC" "<src lang=\"shell\">\n?\n</src>"))

(provide 'init-org/code)
