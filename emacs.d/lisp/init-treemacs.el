(require 'treemacs)

(setq treemacs-no-png-images t)

;; single clicks plz
(define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action)

(provide 'init-treemacs)
