(require 'ledger-mode)

(defun mjhoy/ledger-setup ()
  "Setup for ledger mode."
  (abbrev-mode 1))

(add-hook 'mjhoy/ledger-setup 'ledger-mode-hook)

(provide 'init-ledger)
