(require 'web-mode)
(require 'init-flycheck)
(require 'init-eglot)
(require 'prettier-js)

(add-to-list 'auto-mode-alist '("\\.ts\\'" .  tsx-ts-mode))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

(defun mjhoy/setup-typescript-ts-mode ()
  "My setup for tsx-ts-mode and typescript-ts-mode."
  (eglot-ensure)
  (prettier-js-mode)
  )

(add-hook 'tsx-ts-mode-hook 'mjhoy/setup-typescript-ts-mode)
(add-hook 'typescript-ts-mode-hook 'mjhoy/setup-typescript-ts-mode)

(setq prettier-js-use-modules-bin t)

;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)

(provide 'init-typescript)
