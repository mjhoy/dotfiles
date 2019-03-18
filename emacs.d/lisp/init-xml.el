(defun xml-pretty-print (beg end &optional arg)
  "Reformat the region between BEG and END.
    With optional ARG, also auto-fill."
  (interactive "*r\nP")
  (shell-command-on-region beg end "xmllint --format -" t t))

(provide 'init-xml)
