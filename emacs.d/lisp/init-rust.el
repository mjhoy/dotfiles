(require 'init-flycheck)

(setq rust-mode-treesitter-derive t)    ; use treesitter grammar
(require 'rust-mode)

(defun mjhoy/init-rust-mode ()
  "Set up rust mode"
  (eglot-ensure)
  (setq rust-format-on-save t)
  )

(add-hook 'rust-mode-hook 'mjhoy/init-rust-mode)

(provide 'init-rust)
