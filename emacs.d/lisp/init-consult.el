(require 'consult)

;; Original: switch-to-buffer
(global-set-key (kbd "C-x b") 'consult-buffer)
;; Original: goto-line
(global-set-key (kbd "M-g g") 'consult-goto-line)
;; Original: yank-pop
(global-set-key (kbd "M-y") 'consult-yank-pop)

(consult-customize
 consult-line
 :initial (thing-at-point 'symbol))

;; Searching in projects
(global-set-key (kbd "C-c p s s") 'consult-ripgrep)
(global-set-key (kbd "C-c p s l") 'consult-line-multi)
(global-set-key (kbd "C-c p s i") 'consult-imenu-multi)
(global-set-key (kbd "C-c p f") 'project-find-file)
(global-set-key (kbd "C-c p d") 'consult-find)
(global-set-key (kbd "C-c p b") 'consult-project-buffer)

;; Searching in files
(global-set-key (kbd "C-c s o") 'consult-outline)
(global-set-key (kbd "C-c s s") 'consult-line)
(global-set-key (kbd "C-c s i") 'consult-imenu)
(global-set-key (kbd "C-c s e") 'consult-flymake)

(provide 'init-consult)
