(defun mjhoy/ansi-term-dwim (&optional name)
  "Start a new bash ansi-term and do what I mean.

If the current file is a scss file, and we are in a \"sass\"
directory, start up a term in the parent directory named
\"compass ansi-term\". This assumes a standard compass layout and
that the term is started to run the command `compass watch`.

Otherwise, ask for a name for the new term buffer and start one
in the current directory.
"
  (interactive)
  (let ((bash-exec (if nixos
                       "/run/current-system/sw/bin/bash"
                     "/bin/bash"))
        (dirname (file-name-nondirectory
                  (directory-file-name default-directory))))

    (cond
     ;; compass term
     ((and (not (null buffer-file-name))
           (string= "sass" dirname)
           (string= "scss" (file-name-extension buffer-file-name)))
      (let ((default-directory
              (expand-file-name "../" default-directory)))
        (ansi-term bash-exec "compass ansi-term")))
     ;; mu4e: assume offlineimap
     ((string-match "^\*mu4e" (buffer-name))
      (ansi-term bash-exec "offlineimap ansi-term"))
     ;; otherwise: general term
     (t
      (let ((name (or name
                      (read-from-minibuffer "Buffer name: "))))
        (if (and name (not (string= "" name)))
            (ansi-term bash-exec (concat name " ansi-term"))
          (ansi-term bash-exec)))))))

(global-set-key (kbd "C-c t") 'mjhoy/ansi-term-dwim)

(defun mjhoy/term-hooks ()
  ;; yank in ansi term, C-c C-y
  (define-key term-raw-escape-map "\C-y"
    (lambda ()
      (interactive)
      (term-send-raw-string (current-kill 0)))))
(add-hook 'term-mode-hook 'mjhoy/term-hooks)

(provide 'init-term)
