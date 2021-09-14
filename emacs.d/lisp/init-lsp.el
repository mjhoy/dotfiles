(require 'init-markdown)
(require 'lsp-mode)
(require 'lsp-ui)
(require 'init-company)
(require 'posframe)
(require 'dap-mode)

(setq lsp-prefer-flymake nil)

(setq lsp-ui-doc-enable nil)
(setq lsp-ui-peek-enable nil)
(setq lsp-ui-sideline-show-diagnostics nil)
(setq lsp-ui-sideline-show-hover nil)
(setq lsp-ui-sideline-show-code-actions nil)

(defun mjhoy/setup-lsp-mode ()
  "My setup for lsp-mode."
  (dap-mode)
  (dap-ui-mode))

(provide 'init-lsp)
