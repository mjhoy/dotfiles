(mjhoy/require-package 'js2-mode)
(mjhoy/require-package 'rjsx-mode)

(setq js-indent-level 2)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(provide 'init-javascript)
