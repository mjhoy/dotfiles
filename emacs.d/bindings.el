;; global bindings
;; ===============


; find-file-at-point (replaces 'set-fill-column)
(global-set-key (kbd "C-x f") 'find-file-at-point)

; apple dictionary search of current word
; (replaces 'describe-no-warranty)
(global-set-key (kbd "C-h C-w") 'mjhoy/lookup-apple-dictionary)

;; dash lookup (mac)
;; replaces 'view-emacs-debugging
(global-set-key (kbd "C-h C-d") 'mjhoy/lookup-dash)

;; begone, crazy command
(global-unset-key (kbd "C-x C-u"))

;; hippy expand
(global-set-key "\M- " 'hippie-expand)

;; org agenda
(global-set-key (kbd "C-c a") 'org-agenda)

;; magit stuff

;; magit-blame-mode
(global-set-key (kbd "C-x g b") 'magit-blame-mode)
