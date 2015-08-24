(require 'init-basic)
(require 'init-helm)

;; should maybe put in init-helm?

(defun mjhoy/find-init-file (arg)
  (interactive "P")
  (let ((default-directory
          (concat user-emacs-directory "lisp/")))
    (helm-find-files arg)))

(global-set-key (kbd "C-c d") 'mjhoy/find-init-file)

(provide 'init-dotfile-shortcuts)
