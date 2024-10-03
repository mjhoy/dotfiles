(require 'project)

(global-set-key (kbd "C-c p p") 'project-switch-project)
(global-set-key (kbd "C-c p &") 'project-async-shell-command)

(setq project-vc-extra-root-markers '(".project"))

(define-key project-prefix-map "m" #'magit-project-status)
(add-to-list 'project-switch-commands '(magit-project-status "Magit") t)

(provide 'init-project)
