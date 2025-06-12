(require 'sensitive-mode)
(require 'mjhoy-misc)
(require 'init-basic)

(require 're-builder)
(setq reb-re-syntax 'string)

(require 'bm)
(global-set-key (kbd "C-c m m") 'bm-toggle)
(global-set-key (kbd "C-c m n") 'bm-next)
(global-set-key (kbd "C-c m p") 'bm-previous)

;; these would be triggered unintentionally by the trackpad.
(global-unset-key [(control wheel-up)])
(global-unset-key [(control wheel-down)])

;; Mac specific functions and config
(if macos
    (progn
      ;; (replaces 'describe-no-warranty)
      (global-set-key (kbd "C-h C-w") 'mjhoy/lookup-apple-dictionary)

      ;; replaces 'view-emacs-debugging
      (global-set-key (kbd "C-h C-d") 'mjhoy/lookup-dash)

      ;; Darwin's ls does not support the --dired option.
      (setq dired-use-ls-dired nil)

      ;; Option key is meta
      (setq ns-alternate-modifier 'meta)

      ;; Command key is super
      (setq ns-command-modifier 'super)
      ))

;; Macport specific stuff
(if macport
    (progn
      ;; Meta/super keys
      (setq mac-option-modifier 'meta)
      (setq mac-command-modifier 'super)

      ;; OSX copy/paste
      (global-set-key (kbd "s-v") 'yank)
      (global-set-key (kbd "s-c") 'kill-ring-save)

      ;; Frame title
      (setq frame-title-format '("" "%b @ Emacs"))
      ))

(defun mjhoy/diff-current-buffer-with-file ()
  (interactive)
  (diff-buffer-with-file (current-buffer)))

(defun mjhoy/toggle-require-final-newline ()
  "Toggle whether emacs should require the final newline (defaults to true)."
  (interactive)
  (if require-final-newline
      (progn
        (setq-local require-final-newline nil)
        (message "require-final-newline set to false"))
    (progn
      (setq-local require-final-newline t)
        (message "require-final-newline set to true"))
      )
  )

;; expand line
(defun mjhoy/expand-line ()
  (interactive)
  (let ((hippie-expand-try-functions-list '(try-expand-line try-expand-line-all-buffers)))
    (call-interactively 'hippie-expand)))

(defun mjhoy/show-current-line-position ()
  "Print out '</path/to/file>:<line-number>'"
  (interactive)
  (let ((path-with-line-number
         (concat (buffer-file-name) ":" (number-to-string (line-number-at-pos)))))
    (message path-with-line-number)))

(defun mjhoy/current-iso-datetime ()
  "Insert the current time in ISO 8601 format."
  (interactive)
  (insert (format-time-string "%Y-%m-%dT%H:%M:%S%z")))

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
