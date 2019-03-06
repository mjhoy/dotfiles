(mjhoy/require-package 'flycheck)
(mjhoy/require-package 'flycheck-haskell)
(mjhoy/require-package 'flycheck-rust)

(add-hook 'js-mode-hook   #'flycheck-mode)

(eval-after-load 'scss-mode
  '(add-hook 'scss-mode-hook #'flycheck-mode))

(eval-after-load 'haskell-mode
  '(progn
     (add-hook 'flycheck-mode-hook #'flycheck-haskell-setup)))

(eval-after-load 'ruby-mode
  '(add-hook 'ruby-mode-hook #'flycheck-mode))

(global-set-key (kbd "C-c 1") 'flycheck-mode)

(setq-default flycheck-emacs-lisp-load-path 'inherit)

(setq flycheck-ruby-rubocop-executable "bin/rubocop")

(provide 'init-flycheck)
