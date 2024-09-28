(require 'consult)

;; Original: switch-to-buffer
(global-set-key (kbd "C-x b") 'consult-buffer)
(global-set-key (kbd "C-c p s") 'consult-ripgrep)
(global-set-key (kbd "C-c p f") 'consult-fd)
(global-set-key (kbd "C-c p b") 'consult-project-buffer)
(global-set-key (kbd "C-c C-s") 'consult-line)

(provide 'init-consult)
