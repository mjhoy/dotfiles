(mjhoy/require-package 'flycheck)
(mjhoy/require-package 'flycheck-haskell)
(mjhoy/require-package 'flycheck-rust)

(add-hook 'js-mode-hook   #'flycheck-mode)
(add-hook 'c-mode-hook    #'flycheck-mode)

(eval-after-load 'scss-mode
  '(add-hook 'scss-mode-hook #'flycheck-mode))

(eval-after-load 'haskell-mode
  '(progn
     (add-hook 'haskell-mode-hook #'flycheck-mode)
     (add-hook 'flycheck-mode-hook #'flycheck-haskell-setup)))

(eval-after-load 'rust-mode
  '(progn
     (add-hook 'rust-mode-hook #'flycheck-mode)
     (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)))

(global-set-key (kbd "C-c 1") 'flycheck-mode)

(provide 'init-flycheck)
