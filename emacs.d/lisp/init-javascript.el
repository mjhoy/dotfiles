(setq js-indent-level 2)
(setq js2-mode-show-parse-errors nil)
(setq js2-mode-show-strict-warnings nil)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(provide 'init-javascript)
