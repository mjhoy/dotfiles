(require 'web-mode)
(require 'init-flycheck)
(require 'init-eglot)

(add-to-list 'eglot-server-programs
             '((typescript-mode) "typescript-language-server" "--stdio"))

(add-to-list 'auto-mode-alist '("\\.ts\\'" .  tsx-ts-mode))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

(defun mjhoy/setup-tsx-ts-mode ()
  "My setup for tsx-ts-mode."
  (eglot-ensure)
  )

(add-hook 'tsx-ts-mode-hook 'mjhoy/setup-tsx-ts-mode)

;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

(provide 'init-typescript)
