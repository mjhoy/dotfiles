(require 'markdown-mode)

(setq-default markdown-asymmetric-header t)

(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
(autoload 'gfm-mode "markdown-mode" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

(defun mjhoy/markdown-mode-setup ()
  "Setup for my markdown mode."

  ;; org-mode-ish bindings
  (define-key markdown-mode-map (kbd "M-RET") 'markdown-insert-header-dwim)
  (gfm-mode)
  )

(add-hook 'markdown-mode-hook 'mjhoy/markdown-mode-setup)

;; org-mode-ish key bindings


(provide 'init-markdown)
