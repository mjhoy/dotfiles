(add-to-list 'load-path
             (expand-file-name "site-lisp/copilot" user-emacs-directory))

;; https://github.com/zerolfx/copilot.el
(if (locate-file "copilot.el" load-path)
    (progn
      (require 'copilot)
      (add-hook 'prog-mode-hook 'copilot-mode)

      (with-eval-after-load 'company
        ;; disable inline previews
        (delq 'company-preview-if-just-one-frontend company-frontends))

      (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
      (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)
      ))

(provide 'init-copilot)
