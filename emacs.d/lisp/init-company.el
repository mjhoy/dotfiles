(require 'init-basic)
(require 'init-yas)
(require 'company)

(defun mjhoy/setup-company-mode ()
  "My setup for company mode."
  (yas-minor-mode-on) ; Appears to be used for completion.
  )

(add-hook 'company-mode-hook #'mjhoy/setup-company-mode)
(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "M-SPC") 'company-complete)
(setq company-idle-delay 0.5)
(setq company-tooltip-align-annotations t)

(define-key company-active-map (kbd "C-n")
  (fni (company-complete-common-or-cycle 1)))

(define-key company-active-map (kbd "C-p")
  (fni (company-complete-common-or-cycle -1)))

(provide 'init-company)
