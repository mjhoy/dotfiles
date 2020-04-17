(require 'lsp-mode)
(require 'lsp-ui)
(require 'init-company)
(require 'company-lsp)
(require 'posframe)
(require 'dap-mode)

(setq lsp-prefer-flymake nil)

(setq lsp-ui-doc-enable t)
(setq lsp-ui-peek-enable t)

(defun mjhoy/setup-lsp-mode ()
  "My setup for lsp-mode."
  (dap-mode)
  (dap-ui-mode))

(provide 'init-lsp)
