(require 'init-flycheck)

(setopt rust-mode-treesitter-derive t)    ; use treesitter grammar
(require 'rust-mode)

(defun mjhoy/init-rust-mode ()
  "Set up rust mode"
  (eglot-ensure)
  (setopt rust-format-on-save t)
  )

(add-hook 'rust-mode-hook 'mjhoy/init-rust-mode)

(provide 'init-rust)
