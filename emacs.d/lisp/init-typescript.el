(require 'web-mode)
(require 'init-flycheck)
(require 'init-eglot)

(add-to-list 'eglot-server-programs
             '((typescript-mode) "typescript-language-server" "--stdio"))

(add-to-list 'auto-mode-alist '("\\.ts\\'" .  tsx-ts-mode))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

(defun mjhoy/setup-typescript-ts-mode ()
  "My setup for tsx-ts-mode and typescript-ts-mode."
  (eglot-ensure)
  (add-hook 'before-save-hook #'prettier-prettify nil t)
  )

(add-hook 'tsx-ts-mode-hook 'mjhoy/setup-typescript-ts-mode)
(add-hook 'typescript-ts-mode-hook 'mjhoy/setup-typescript-ts-mode)

;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

(provide 'init-typescript)
