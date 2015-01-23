(mjhoy/require-package 'php-mode)

(add-to-list 'auto-mode-alist '("\\.module\\'" . php-mode))

(add-hook 'php-mode-hook 'php-enable-drupal-coding-style)

;; geben init?

(provide 'init-php)
