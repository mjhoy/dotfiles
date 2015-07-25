(defun mjhoy/ansi-term (&optional name)
  "Start a new bash ansi-term and ask for a name"
  (interactive (list (read-from-minibuffer "Buffer name: ")))
  (let ((bash-exec (if nixos
                       "/run/current-system/sw/bin/bash"
                     "/bin/bash")))
    (if (and name (not (string= "" name)))
        (ansi-term bash-exec (concat name " ansi-term"))
      (ansi-term bash-exec))))

(global-set-key (kbd "C-c t") 'mjhoy/ansi-term)

(defun mjhoy/term-hooks ()
  ;; yank in ansi term, C-c C-y
  (define-key term-raw-escape-map "\C-y"
    (lambda ()
      (interactive)
      (term-send-raw-string (current-kill 0)))))
(add-hook 'term-mode-hook 'mjhoy/term-hooks)

(provide 'init-term)
