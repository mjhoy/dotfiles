(mjhoy/require-package 'flycheck)
(mjhoy/require-package 'flycheck-haskell)
(mjhoy/require-package 'flycheck-rust)

(add-hook 'js-mode-hook   #'flycheck-mode)

(eval-after-load 'scss-mode
  '(add-hook 'scss-mode-hook #'flycheck-mode))

(eval-after-load 'haskell-mode
  '(progn
     (add-hook 'flycheck-mode-hook #'flycheck-haskell-setup)))

(global-set-key (kbd "C-c 1") 'flycheck-mode)

(setq flycheck-ruby-rubocop-executable "bin/rubocop")

(provide 'init-flycheck)
