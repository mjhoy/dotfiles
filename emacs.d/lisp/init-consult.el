(require 'consult)

;; Original: switch-to-buffer
(global-set-key (kbd "C-x b") 'consult-buffer)
;; Original: goto-line
(global-set-key (kbd "M-g g") 'consult-goto-line)

;; Searching in projects
(global-set-key (kbd "C-c p s s") 'consult-ripgrep)
(global-set-key (kbd "C-c p s l") 'consult-line-multi)
(global-set-key (kbd "C-c p s i") 'consult-imenu-multi)

(global-set-key (kbd "C-c p f") 'consult-fd)
(global-set-key (kbd "C-c p b") 'consult-project-buffer)
(global-set-key (kbd "C-c s") 'consult-line)
(global-set-key (kbd "C-c e") 'consult-flymake)

(provide 'init-consult)
