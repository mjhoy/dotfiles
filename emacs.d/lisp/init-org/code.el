(setq org-confirm-babel-evaluate nil)

(require 'ob-sh)
; do I want 'ob-shell ?

(require 'ob-sql)

(require 'ob-haskell)

(require 'ob-scheme)

;; fontify our code blocks
(setq org-src-fontify-natively t)

;; edit src in the current window
(setq org-src-window-setup 'current-window)

;; structure shortcuts
(add-to-list 'org-structure-template-alist
             '("hs" "#+begin_src haskell\n?\n#+end_src" "<src lang=\"haskell\">\n?\n</src>"))
(add-to-list 'org-structure-template-alist
             '("rs" "#+begin_src rust\n?\n#+end_src" "<src lang=\"rust\">\n?\n</src>"))
(add-to-list 'org-structure-template-alist
             '("sh" "#+begin_src sh\n?\n#+end_src" "<src lang=\"sh\">\n?\n</src>"))
(add-to-list 'org-structure-template-alist
             '("theorem" "#+begin_theorem\n?\n#+end_theorem" "<theorem>\n?\n</theorem>"))

(provide 'init-org/code)
