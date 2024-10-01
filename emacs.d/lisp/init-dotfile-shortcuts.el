(defun mjhoy/find-init-file (arg)
  "Open a consult minibuffer session ready to find an init file."
  (interactive "P")
  (consult-fd user-emacs-directory
              "init.*el# "))

(global-set-key (kbd "C-c d") 'mjhoy/find-init-file)

(provide 'init-dotfile-shortcuts)
