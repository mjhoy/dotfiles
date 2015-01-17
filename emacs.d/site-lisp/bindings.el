;; global bindings
;; ===============

;; idomenu
(global-set-key (kbd "C-c s") 'idomenu)

; find-file-at-point (replaces 'set-fill-column)
(global-set-key (kbd "C-x f") 'find-file-at-point)

; apple dictionary search of current word
; (replaces 'describe-no-warranty)
(global-set-key (kbd "C-h C-w") 'mjhoy/lookup-apple-dictionary)

;; dash lookup (mac)
;; replaces 'view-emacs-debugging
(global-set-key (kbd "C-h C-d") 'mjhoy/lookup-dash)

;; mjhoy/ansi-term
(global-set-key (kbd "C-c t") 'mjhoy/ansi-term)

;; begone, crazy command
(global-unset-key (kbd "C-x C-u"))
;; (we can safely enable it)
(put 'upcase-region 'disabled nil)

;; org mode keys
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c l") 'org-store-link)

;; magit stuff

;; magit-blame-mode
(global-set-key (kbd "C-x g b") 'magit-blame-mode)
