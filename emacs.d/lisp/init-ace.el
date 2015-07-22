(mjhoy/require-package 'ace-window)
(mjhoy/require-package 'avy)

;; previously other-window
(global-set-key (kbd "C-x o") 'ace-window)

(global-set-key (kbd "C-c ;") 'avy-goto-char-2)
(global-set-key (kbd "C-c '") 'avy-goto-line)

(provide 'init-ace)
