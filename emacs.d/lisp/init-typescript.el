(require 'web-mode)
(require 'typescript-mode)
(require 'init-flycheck)

(add-to-list 'auto-mode-alist '("\\.ts\\'" .  typescript-mode))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))


;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)

(defun mjhoy/setup-typescript-mode ()
  "My setup for typescript."
  (interactive)
  (lsp)
  )

(add-hook 'typescript-mode-hook #'mjhoy/setup-typescript-mode)
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (mjhoy/setup-typescript-mode))))

(provide 'init-typescript)
