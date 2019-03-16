(setq c-default-style "linux")
(setq c-basic-offset 4)

(defun mjhoy/c-init ()
  "My setup for c files."
  (setq c-basic-offset 4)
  (flycheck-mode 1)
  (if (or (file-exists-p "makefile")
          (file-exists-p "Makefile"))
      (set (make-local-variable 'compilation-read-command) nil))
  (if (file-exists-p "~/.nix-profile/include")
      (let ((includes-path (expand-file-name "~/.nix-profile/include/")))
        (setq flycheck-clang-include-path
              (list includes-path))
        (setq company-clang-arguments
              (list (concat "-I" includes-path))))
    )
  )

(defun mjhoy/my-c-initialization ()
  (define-key c-mode-base-map (kbd "C-m") 'c-context-line-break)
  (define-key c-mode-base-map (kbd "C-c C-c") 'compile)
  (define-key c-mode-base-map (kbd "C-h C-d") 'man)
  )

(add-hook 'c-initialization-hook 'mjhoy/my-c-initialization)
(add-hook 'c-mode-hook 'mjhoy/c-init)

(provide 'init-c)
