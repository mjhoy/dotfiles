(setq c-default-style "linux")
(setq c-basic-offset 4)

(defun mjhoy/c-init ()
  (setq c-basic-offset 4)
  (if (or (file-exists-p "makefile")
          (file-exists-p "Makefile"))
      (set (make-local-variable 'compilation-read-command) nil)))

(defun mjhoy/my-c-init ()
  (define-key c-mode-base-map (kbd "C-m") 'c-context-line-break)
  (define-key c-mode-base-map (kbd "C-c C-c") 'compile))

(add-hook 'c-initialization-hook 'mjhoy/my-c-init)
(add-hook 'c-mode-hook 'mjhoy/c-init)

(provide 'init-c)
