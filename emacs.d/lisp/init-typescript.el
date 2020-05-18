(require 'web-mode)
(require 'typescript-mode)
(require 'tide)
(require 'init-flycheck)

(add-to-list 'auto-mode-alist '("\\.ts\\'" .  typescript-mode))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))


;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)

(defun mjhoy/setup-tide ()
  "My setup for tide."
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1)
  )

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'mjhoy/setup-tide)
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (mjhoy/setup-tide))))

(provide 'init-typescript)
