(require 'consult)

;; Original: switch-to-buffer
(global-set-key (kbd "C-x b") 'consult-buffer)
(global-set-key (kbd "C-c s") 'consult-ripgrep)

(provide 'init-consult)
