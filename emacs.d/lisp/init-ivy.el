(require 'ivy)

(ivy-mode 1)

(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-y") 'counsel-yank-pop)

(provide 'init-ivy)
