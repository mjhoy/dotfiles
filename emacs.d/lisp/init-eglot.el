(require 'eglot)

(add-to-list 'eglot-ignored-server-capabilities
             :inlayHintProvider)

;; See https://github.com/joaotavora/eglot/issues/574
(defun mjhoy/eglot-organize-imports () (interactive)
       (eglot-code-actions nil nil "source.organizeImports" t))

(with-eval-after-load 'eglot
  (define-key eglot-mode-map (kbd "C-c C-r") 'eglot-rename))

(provide 'init-eglot)
