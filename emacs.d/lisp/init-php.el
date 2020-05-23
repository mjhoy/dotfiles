(add-to-list 'auto-mode-alist '("\\.module\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'"    . php-mode))

(add-to-list 'auto-mode-alist '("php\\.ini\\'"           . conf-mode))
(add-to-list 'auto-mode-alist '("php\\.ini\\.default\\'" . conf-mode))

(add-hook 'php-mode-hook 'php-enable-drupal-coding-style)

(defun mjhoy/setup-php-mode ()
  "Setup for PHP mode."
  (setq c-basic-offset 2)
  (php-enable-drupal-coding-style)
  )

(add-hook 'php-mode-hook 'mjhoy/setup-php-mode)

;; geben init?

(provide 'init-php)
