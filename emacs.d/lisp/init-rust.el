(require 'init-lsp)
(require 'init-flycheck)
(require 'flycheck-rust)

(add-hook 'rust-mode-hook #'flycheck-rust-setup)

(defun mjhoy/init-rust-mode ()
  "Set up rust mode"
  (lsp)
  (setq rust-format-on-save t)
  )

(add-hook 'rust-mode-hook 'mjhoy/init-rust-mode)

(provide 'init-rust)
