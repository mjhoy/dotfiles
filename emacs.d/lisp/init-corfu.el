(require 'corfu)

(global-corfu-mode)
(setq corfu-auto nil)

;; for programming buffers, set auto completion.
(add-hook 'prog-mode-hook
          (lambda ()
            (setq-local corfu-auto t)))

(setq corfu-auto-delay 0.2)
(global-set-key (kbd "M-SPC") 'complete-symbol)

(provide 'init-corfu)
