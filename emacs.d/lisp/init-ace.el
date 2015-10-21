(mjhoy/require-package 'ace-window)
(mjhoy/require-package 'avy)

(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;; previously other-window
(global-set-key (kbd "C-x o") 'ace-window)

(global-set-key (kbd "C-c ;") 'avy-goto-char)
(global-set-key (kbd "C-c '") 'avy-goto-line)

(provide 'init-ace)
