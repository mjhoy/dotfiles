(defconst autosaves-directory
  (expand-file-name "autosaves/"
                    user-emacs-directory))

(setq backup-directory-alist
      (list (cons "."
                  (expand-file-name "backups"
                                    user-emacs-directory))))

(setq backup-by-copying t)

;; save bookmarks immediately
(setq bookmark-save-flag 1)

(setq inhibit-splash-screen t)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq-default indent-tabs-mode nil)
(setq require-final-newline t)
(setq tags-case-fold-search nil)

;; begone, crazy command
(global-unset-key (kbd "C-x C-u"))
(put 'upcase-region 'disabled nil)

;; enable narrowing
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)

;; interactive lambda macro
(defmacro fni (&rest forms)
  "Create an anonymous interactive function"
  `(lambda () (interactive) ,@forms))

(provide 'init-basic)
