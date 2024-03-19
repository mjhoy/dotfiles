(setq js-indent-level 2)
(setq js2-mode-show-parse-errors nil)
(setq js2-mode-show-strict-warnings nil)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-hook 'js-json-mode-hook
          (lambda ()
            (make-local-variable 'indent-tabs-mode)
            (setq indent-tabs-mode nil)))

(provide 'init-javascript)
