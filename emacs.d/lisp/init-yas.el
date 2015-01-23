(mjhoy/require-package 'yasnippet)

(require 'yasnippet)
(yas-reload-all)

;; keep the following in case I turn on yas-global-mode
(add-hook 'term-mode-hook (lambda()     ; disable in term mode, yas
                (yas-minor-mode -1)))   ; interacts poorly with it for
                                        ; some reason

(eval-after-load 'php-mode
  '(add-hook 'php-mode-hook
             '(lambda ()
                (yas-minor-mode))))

(provide 'init-yas)
