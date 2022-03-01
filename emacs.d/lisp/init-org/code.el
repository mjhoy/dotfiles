(setq org-confirm-babel-evaluate nil)

(require 'org-tempo)

(require 'ob-shell)

(require 'ob-sql)

(require 'ob-haskell)

(require 'ob-python)

(require 'ob-R)

(require 'ob-dot)

(setq org-babel-python-command "load-env-mypython3 python")

(require 'ob-scheme)

(require 'ob-diagrams)

;; fontify our code blocks
(setq org-src-fontify-natively t)

;; edit src in the current window
(setq org-src-window-setup 'current-window)

;; preserve indentation of source blocks
;; this makes it possible to generate valid Makefiles
(setq org-src-preserve-indentation t)

(defun mjhoy/org-maybe-refresh-images ()
  (when org-inline-image-overlays
    (org-redisplay-inline-images)))

(add-hook 'org-babel-after-execute-hook 'mjhoy/org-maybe-refresh-images)

;; structure shortcuts
(add-to-list 'org-structure-template-alist
             '("hs" . "src haskell"))
(add-to-list 'org-structure-template-alist
             '("hsnt" . "src haskell :tangle no"))
(add-to-list 'org-structure-template-alist
             '("rs" . "src rust"))
(add-to-list 'org-structure-template-alist
             '("rb" . "src ruby"))
(add-to-list 'org-structure-template-alist
             '("purs" . "src purescript"))
(add-to-list 'org-structure-template-alist
             '("sh" . "src sh"))
(add-to-list 'org-structure-template-alist
             '("theorem" . "theorem"))
(add-to-list 'org-structure-template-alist
             '("def" . "definition"))

(provide 'init-org/code)
