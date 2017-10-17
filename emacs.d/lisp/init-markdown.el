(mjhoy/require-package 'markdown-mode)

(setq-default markdown-asymmetric-header t)

(defun mjhoy/markdown-mode-setup ()
  "Setup for my markdown mode."

  ;; org-mode-ish bindings
  (define-key markdown-mode-map (kbd "M-RET") 'markdown-insert-header-dwim)
  )

(add-hook 'markdown-mode-hook 'mjhoy/markdown-mode-setup)

;; org-mode-ish key bindings


(provide 'init-markdown)
