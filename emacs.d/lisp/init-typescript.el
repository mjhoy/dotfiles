(require 'web-mode)
(require 'typescript-mode)
(require 'tide)
(require 'init-flycheck)

(add-to-list 'auto-mode-alist '("\\.ts\\'" .  web-mode))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))


;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)

(defun mjhoy/setup-tide ()
  "My setup for tide."
  (interactive)
  )

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

(provide 'init-typescript)
