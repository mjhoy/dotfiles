(require 'sensitive-mode)
(require 'mjhoy-misc)

;; (replaces 'describe-no-warranty)
(global-set-key (kbd "C-h C-w") 'mjhoy/lookup-apple-dictionary)

;; replaces 'view-emacs-debugging
(global-set-key (kbd "C-h C-d") 'mjhoy/lookup-dash)

(defun mjhoy/diff-current-buffer-with-file ()
  (interactive)
  (diff-buffer-with-file (current-buffer)))

(global-set-key (kbd "C-c b d") 'mjhoy/diff-current-buffer-with-file)

(provide 'init-misc)
