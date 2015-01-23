(mjhoy/require-package 'ibuffer-vc)

(require 'ibuffer-vc)
(add-hook 'ibuffer-hook
          (lambda ()
            (ibuffer-vc-set-filter-groups-by-vc-root)
            (unless (eq ibuffer-sorting-mode 'alphabetic)
              (ibuffer-do-sort-by-alphabetic))))
(global-set-key (kbd "C-x C-b") 'ibuffer)

(provide 'init-ibuffer)
