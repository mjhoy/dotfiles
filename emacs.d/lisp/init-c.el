(setq c-default-style "linux")
(setq c-basic-offset 4)

(defun mjhoy/c-init ()
  (setq c-basic-offset 4)
  (if (or (file-exists-p "makefile")
          (file-exists-p "Makefile"))
      (set (make-local-variable 'compilation-read-command) nil)))

(defun mjhoy/my-make-CR-do-indent ()
  (define-key c-mode-base-map "\C-m" 'c-context-line-break))

(add-hook 'c-initialization-hook 'mjhoy/my-make-CR-do-indent)
(add-hook 'c-mode-hook 'mjhoy/c-init)

(provide 'init-c)
