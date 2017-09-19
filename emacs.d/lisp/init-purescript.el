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
    (setq psc-ide-source-globs
          (append
           '("src/**/*.purs")
           (cl-remove-if (lambda (s) (equalp "" s))
                         (split-string
                          (shell-command-to-string "psc-package sources")
                          "\n"))
           )
          )))

(add-hook 'purescript-mode-hook 'mjhoy/purescript-mode-setup)

(setq psc-ide-use-npm-bin t)
(setq psc-ide-use-purs t)

(provide 'init-purescript)
