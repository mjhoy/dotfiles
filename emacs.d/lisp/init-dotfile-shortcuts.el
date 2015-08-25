(require 'init-helm)

;; should maybe put in init-helm?

(defun mjhoy/find-init-file (arg)
  (interactive "P")
  (helm-find-files-1 (expand-file-name
                      (concat user-emacs-directory "lisp/"))))

(global-set-key (kbd "C-c d") 'mjhoy/find-init-file)

(provide 'init-dotfile-shortcuts)
