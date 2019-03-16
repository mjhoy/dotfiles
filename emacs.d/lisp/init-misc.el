(require 'sensitive-mode)
(require 'mjhoy-misc)
(require 'init-basic)

(require 're-builder)
(setq reb-re-syntax 'string)

(require 'bm)
(global-set-key (kbd "C-c m m") 'bm-toggle)
(global-set-key (kbd "C-c m n") 'bm-next)
(global-set-key (kbd "C-c m p") 'bm-previous)


;; Apple specific functions
(if (eq system-type 'darwin)
    (progn
      ;; (replaces 'describe-no-warranty)
      (global-set-key (kbd "C-h C-w") 'mjhoy/lookup-apple-dictionary)

      ;; replaces 'view-emacs-debugging
      (global-set-key (kbd "C-h C-d") 'mjhoy/lookup-dash)))

(defun mjhoy/diff-current-buffer-with-file ()
  (interactive)
  (diff-buffer-with-file (current-buffer)))

;; expand line
(defun mjhoy/expand-line ()
  (interactive)
  (let ((hippie-expand-try-functions-list '(try-expand-line-all-buffers)))
    (call-interactively 'hippie-expand)))

(defun mjhoy/show-current-line-position ()
  "Print out '</path/to/file>:<line-number>'"
  (interactive)
  (let ((path-with-line-number
         (concat (buffer-file-name) ":" (number-to-string (line-number-at-pos)))))
    (message path-with-line-number)))

(define-key global-map (kbd "M-l") 'mjhoy/show-current-line-position)

(global-set-key (kbd "C-x C-l") 'mjhoy/expand-line)

;; buffer bindings
(global-set-key (kbd "C-c b =") 'mjhoy/diff-current-buffer-with-file)
(global-set-key (kbd "C-c b r") 'revert-buffer)

;; quick find files
(global-set-key (kbd "C-c f p") (fni (find-file "~/Dropbox/p.gpg")))
(global-set-key (kbd "C-c f s") (fni (find-file "~/.ssh/config")))

;; ask before quitting
(setq confirm-kill-emacs #'yes-or-no-p)

;; don't be annoying
(setq tags-add-tables nil)

(provide 'init-misc)
