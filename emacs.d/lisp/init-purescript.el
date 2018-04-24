(mjhoy/require-package 'psc-ide)
(mjhoy/require-package 'purescript-mode)
(mjhoy/require-package 'cl-lib)

(defun mjhoy/purescript-mode-setup ()
  "Run to set up purescript mode."
  (psc-ide-mode)
  (flycheck-mode)
  (turn-on-purescript-indentation)
  (turn-on-purescript-decl-scan)
  )

;; This function uses the globs obtained from `psc-package sources` to
;; set `psc-ide-source-globs'.
(defun mjhoy/set-psc-ide-sources-for-psc-package ()
  (interactive)
  (projectile-with-default-dir (projectile-project-root)
    (let ((globs (append
                  '("src/**/*.purs")
                  '("test/**/*.purs")
                  (cl-remove-if (lambda (s) (equalp "" s))
                                (split-string
                                 (shell-command-to-string "psc-package sources")
                                 "\n")))))

      (setq psc-ide-source-globs globs)
      )))

(add-hook 'purescript-mode-hook 'mjhoy/purescript-mode-setup)

;; TODO
;; Add a regex for compilation from psa
;; (defvar purescript-mode-compilation-regex-alist-alist
;;   `((psc ,(rx line-start
;;               (* space) (32 "Error ") "at "
;;               (group (minimal-match (one-or-more (not ":"))))
;;               " line " (group (+ num)) ", column " (group (+ num))
;;               " - line " (group (+ num)) ", column " (group (+ num))
;;               (32 ":")) 1 (2 . 3) (4 . 5) (6))) "\
;; Alist for PureScript errors.  See: `compilation-error-regexp-alist'.")

(setq psc-ide-use-npm-bin t)
(setq psc-ide-use-purs t)

(setq psc-ide-flycheck-ignored-error-codes
      '("UnusedImport" "UnusedExplicitImport" "UnusedDctorImport"))

(provide 'init-purescript)
