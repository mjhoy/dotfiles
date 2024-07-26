(require 'eglot)
(require 'init-lsp-booster)

(add-to-list 'eglot-ignored-server-capabilities
             :inlayHintProvider)

;; See https://github.com/joaotavora/eglot/issues/574
(defun mjhoy/eglot-organize-imports () (interactive)
       (eglot-code-actions nil nil "source.organizeImports" t))

(with-eval-after-load 'eglot
  (progn
    (define-key eglot-mode-map (kbd "C-c C-r") 'eglot-rename)
    (define-key eglot-mode-map (kbd "C-c C-a") 'eglot-code-actions)
    ))

(eglot-booster-mode)

(provide 'init-eglot)
