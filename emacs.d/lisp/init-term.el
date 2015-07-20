(defun mjhoy/ansi-term (&optional name)
  "Start a new bash ansi-term and ask for a name"
  (interactive (list (read-from-minibuffer "Buffer name: ")))
  (if (and name (not (string= "" name)))
      (ansi-term "/bin/bash" (concat name " ansi-term"))
    (ansi-term "/bin/bash")))

(global-set-key (kbd "C-c t") 'mjhoy/ansi-term)

(defun mjhoy/term-hooks ()
  ;; yank in ansi term, C-c C-y
  (define-key term-raw-escape-map "\C-y"
    (lambda ()
      (interactive)
      (term-send-raw-string (current-kill 0)))))
(add-hook 'term-mode-hook 'mjhoy/term-hooks)

(provide 'init-term)
