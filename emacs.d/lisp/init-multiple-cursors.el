(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-S-c C-S-n") 'mc/mark-next-like-this-symbol)

(provide 'init-multiple-cursors)
