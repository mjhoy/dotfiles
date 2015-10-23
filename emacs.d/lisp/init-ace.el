(mjhoy/require-package 'ace-window)
(mjhoy/require-package 'avy)

(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

(global-set-key (kbd "C-x p") 'ace-window)

(global-set-key (kbd "C-c ;") 'avy-goto-char)
(global-set-key (kbd "C-c '") 'avy-goto-line)

(provide 'init-ace)
