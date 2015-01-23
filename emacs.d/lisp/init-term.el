(defun mjhoy/ansi-term (&optional name)
  "Start a new bash ansi-term and ask for a name"
  (interactive (list (read-from-minibuffer "Buffer name: ")))
  (if (and name (not (string= "" name)))
      (ansi-term "/bin/bash" (concat name " ansi-term"))
    (ansi-term "/bin/bash")))

(global-set-key (kbd "C-c t") 'mjhoy/ansi-term)

(provide 'init-term)
