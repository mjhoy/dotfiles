(require 'init-lsp)
(require 'init-flycheck)
(require 'flycheck-rust)

(add-hook 'rust-mode-hook #'flycheck-rust-setup)

(setq lsp-rust-server 'rust-analyzer)

(defun mjhoy/init-rust-mode ()
  "Set up rust mode"
  (lsp)
  (setq rust-format-on-save t)
  (cargo-minor-mode)
  )

(add-hook 'rust-mode-hook 'mjhoy/init-rust-mode)

(provide 'init-rust)
