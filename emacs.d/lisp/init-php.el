(mjhoy/require-package 'php-mode)

(add-to-list 'auto-mode-alist '("\\.module\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'"    . php-mode))

(add-to-list 'auto-mode-alist '("php\\.ini\\'"           . conf-mode))
(add-to-list 'auto-mode-alist '("php\\.ini\\.default\\'" . conf-mode))

(add-hook 'php-mode-hook 'php-enable-drupal-coding-style)

;; geben init?

(provide 'init-php)
