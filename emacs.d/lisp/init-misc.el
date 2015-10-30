(require 'sensitive-mode)
(require 'mjhoy-misc)
(require 'init-basic)

;; misc useful modes here
(mjhoy/require-package 'apache-mode)

;; bm: visual bookmarks
(mjhoy/require-package 'bm)

(require 'bm)
(global-set-key (kbd "C-c m m") 'bm-toggle)
(global-set-key (kbd "C-c m n") 'bm-next)
(global-set-key (kbd "C-c m p") 'bm-previous)

;; (replaces 'describe-no-warranty)
(global-set-key (kbd "C-h C-w") 'mjhoy/lookup-apple-dictionary)

;; replaces 'view-emacs-debugging
(global-set-key (kbd "C-h C-d") 'mjhoy/lookup-dash)

(defun mjhoy/diff-current-buffer-with-file ()
  (interactive)
  (diff-buffer-with-file (current-buffer)))

;; buffer bindings
(global-set-key (kbd "C-c b =") 'mjhoy/diff-current-buffer-with-file)
(global-set-key (kbd "C-c b r") 'revert-buffer)

;; quick find files
(global-set-key (kbd "C-c f p") (fni (find-file "~/Dropbox/p.gpg")))
(global-set-key (kbd "C-c f s") (fni (find-file "~/.ssh/config")))

;; ask before quitting
(setq confirm-kill-emacs #'yes-or-no-p)

(provide 'init-misc)
