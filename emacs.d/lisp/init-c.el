(setq c-default-style "linux")
(setq c-basic-offset 4)

(defun mjhoy/c-init ()
  (setq c-basic-offset 4))

(defun mjhoy/my-make-CR-do-indent ()
  (define-key c-mode-base-map "\C-m" 'c-context-line-break))

(add-hook 'c-initialization-hook 'mjhoy/my-make-CR-do-indent)
(add-hook 'c-mode-hook 'mjhoy/c-init)

(provide 'init-c)
