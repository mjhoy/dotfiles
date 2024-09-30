(require 'corfu)

(global-corfu-mode)
(setq corfu-auto t)
(setq corfu-auto-delay 0.2)
(global-set-key (kbd "M-SPC") 'complete-symbol)

(provide 'init-corfu)
