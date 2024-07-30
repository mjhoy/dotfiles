(require 'ivy)
(require 'ivy-prescient)

(ivy-mode 1)
(ivy-prescient-mode 1)

(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "M-x") 'counsel-M-x)

(provide 'init-ivy)
