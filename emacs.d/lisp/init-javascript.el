(setopt js-indent-level 2)
(setopt js2-mode-show-parse-errors nil)
(setopt js2-mode-show-strict-warnings nil)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-hook 'js-json-mode-hook
          (lambda ()
            (make-local-variable 'indent-tabs-mode)
            (setopt indent-tabs-mode nil)))

(provide 'init-javascript)
