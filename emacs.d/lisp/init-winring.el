(require 'winring)
(winring-initialize)

(global-set-key (kbd "s-<right>") 'winring-next-configuration)
(global-set-key (kbd "s-<left>") 'winring-prev-configuration)

(provide 'init-winring)
