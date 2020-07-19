(defun mjhoy/find-init-file (arg)
  (interactive "P")
  (counsel-find-file (expand-file-name
                       (concat user-emacs-directory "lisp/"))))

(global-set-key (kbd "C-c d") 'mjhoy/find-init-file)

(provide 'init-dotfile-shortcuts)
