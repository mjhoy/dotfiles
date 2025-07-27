(require 'corfu)

(global-corfu-mode)
(setopt corfu-auto nil)

;; for programming buffers, set auto completion.
(add-hook 'prog-mode-hook
          (lambda ()
            (setq-local corfu-auto t)))

(setopt corfu-auto-delay 0.2)
(global-set-key (kbd "M-SPC") 'complete-symbol)

(provide 'init-corfu)
