(require 'eglot)

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

(setq-default eglot-workspace-configuration '((haskell (formattingProvider . "fourmolu"))))

(add-to-list 'eglot-server-programs
             '((hl7-mode) "/Users/michaelhoy/proj/pipet/target/release/pipet"))
(setq eglot-connect-timeout 10)

(provide 'init-eglot)
