(require 'web-mode)
(require 'init-flycheck)
(require 'init-eglot)

(add-to-list 'eglot-server-programs
             '((typescript-mode) "typescript-language-server" "--stdio"))

(add-to-list 'auto-mode-alist '("\\.ts\\'" .  web-mode))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))

;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

(provide 'init-typescript)
