(require 'init-flycheck)

(defun mjhoy/init-rust-mode ()
  "Set up rust mode"
  (eglot-ensure)
  (setq rust-format-on-save t)
  (cargo-minor-mode)
  )

(add-hook 'rust-mode-hook 'mjhoy/init-rust-mode)

(provide 'init-rust)
