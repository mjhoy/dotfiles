(defconst autosaves-directory
  (expand-file-name "autosaves/"
                    user-emacs-directory))

(setopt backup-directory-alist
      (list (cons "."
                  (expand-file-name "backups"
                                    user-emacs-directory))))

(setopt backup-by-copying t)
(setopt version-control t)
(setopt kept-new-versions 10)
(setopt kept-old-versions 2)
(setopt delete-old-versions t)
(setopt vc-make-backup-files t)

(make-directory autosaves-directory t)
(setopt auto-save-file-name-transforms
        `((".*" ,autosaves-directory t)))

(setopt create-lockfiles nil)

;; Don't back up possibly sensitive files.
(defconst mjhoy/sensitive-file-regexp
  "/\\.?\\(authinfo\\|netrc\\)\\'")

(defun mjhoy/sensitive-file-p (file)
  (string-match-p mjhoy/sensitive-file-regexp file))

(setopt backup-enable-predicate
        (lambda (file)
          (and (normal-backup-enable-predicate file)
               (not (mjhoy/sensitive-file-p file)))))

(defun mjhoy/disable-auto-save-for-sensitive-files ()
  (when (and buffer-file-name
             (mjhoy/sensitive-file-p buffer-file-name))
    (auto-save-mode -1)))

(add-hook 'find-file-hook #'mjhoy/disable-auto-save-for-sensitive-files)

;; save bookmarks immediately
(setopt bookmark-save-flag 1)

(set-language-environment 'utf-8)
(setopt locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq-default indent-tabs-mode nil)
(setopt require-final-newline t)
(setopt tags-case-fold-search nil)

;; begone, crazy command
(global-unset-key (kbd "C-x C-u"))
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(global-set-key (kbd "C-x f") 'find-file)

;; default is 60, let's bump this
(setopt kill-ring-max 500)

;; enable narrowing
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)

;; line truncation
(setq-default truncate-lines t)

;; a reasonable fill-column length
(setq-default fill-column 80)

;; interactive lambda macro
(defmacro fni (&rest forms)
  "Create an anonymous interactive function"
  `(lambda () (interactive) ,@forms))

(setopt auth-sources '("~/.authinfo" "~/.authinfo.gpg" "~/.netrc"))

;; A smarter keyboard-quit: https://emacsredux.com/blog/2025/06/01/let-s-make-keyboard-quit-smarter/
(defun mjhoy/keyboard-quit-dwim ()
  "A smarter version of the built-in `keyboard-quit'.

When the minibuffer is open, close it, even if it's not in focus."
  (interactive)
  (if (active-minibuffer-window)
      (if (minibufferp)
          (minibuffer-keyboard-quit)
        (abort-recursive-edit))
    (keyboard-quit)))

(global-set-key [remap keyboard-quit] #'mjhoy/keyboard-quit-dwim)

(provide 'init-basic)
