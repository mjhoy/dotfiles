(mjhoy/require-package 'idomenu)
(mjhoy/require-package 'ido-vertical-mode)
(mjhoy/require-package 'smex)
(mjhoy/require-package 'flx-ido)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 'files)

(require 'ido-vertical-mode)
(ido-vertical-mode 1)

(require 'smex)
(smex-initialize)

(global-set-key (kbd "C-c s") 'idomenu)

(provide 'init-ido)
