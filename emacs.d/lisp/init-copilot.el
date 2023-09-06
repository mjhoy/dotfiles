(add-to-list 'load-path
             (expand-file-name "site-lisp/copilot" user-emacs-directory))

;; https://github.com/zerolfx/copilot.el
(if (locate-file "copilot.el" load-path)
    (progn
      (require 'copilot)

      (defvar mjhoy/auto-copilot-mode-enabled nil
        "Whether or not copilot mode is enabled automatically")

      (defun mjhoy/enable-auto-copilot-mode ()
        "Enable automatic copilot mode"
        (interactive)
        (setq mjhoy/auto-copilot-mode-enabled t))

      (defun mjhoy/disable-auto-copilot-mode ()
        "Disable automatic copilot mode"
        (interactive)
        (setq mjhoy/auto-copilot-mode-enabled nil))

      (defun mjhoy/maybe-init-copilot-mode ()
        "Potentially initialize copilot mode"
        (when mjhoy/auto-copilot-mode-enabled
          (copilot-mode 1)))

      (add-hook 'prog-mode-hook 'mjhoy/maybe-init-copilot-mode)

      (with-eval-after-load 'company
        ;; disable inline previews
        (delq 'company-preview-if-just-one-frontend company-frontends))

      (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
      (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)
      ))

(provide 'init-copilot)
