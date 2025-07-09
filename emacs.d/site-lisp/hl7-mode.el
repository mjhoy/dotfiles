;; Major mode for HL7 2.x

(defvar hl7-mode-hook nil)

(defconst hl7-font-lock-keywords
  (list
   '("\\|" . font-lock-keyword-face)
   )
  "HL7 Highlighting")

(defun hl7-mode ()
  "Major mode for editing HL7 2.x files."
  (interactive)
  (kill-all-local-variables)

  (set (make-local-variable 'font-lock-defaults) '(hl7-font-lock-keywords))

  (setq major-mode 'hl7-mode)
  (setq mode-name "HL7")
  (run-hooks 'hl7-mode-hook))

(provide 'hl7-mode)
