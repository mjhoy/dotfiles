(require 'vundo)

(setq vundo-glyph-alist vundo-unicode-symbols)

(global-set-key (kbd "C-c /") #'vundo)

(provide 'init-vundo)
