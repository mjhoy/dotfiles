(defun mjhoy/open-org-notebook (filename &optional use-completion)
  (if use-completion
      (consult-fd org-directory (concat filename "# "))
    (find-file (concat org-directory filename))))

(defmacro openo (&rest forms)
  `(fni (mjhoy/open-org-notebook ,@forms)))

(global-set-key (kbd "C-c o a") (openo "archive" t))
(global-set-key (kbd "C-c o p") (openo "programming_notes/" t))
(global-set-key (kbd "C-c o r") (openo "reading_notes.org"))
(global-set-key (kbd "C-c o i") (openo "inbox.org"))
(global-set-key (kbd "C-c o d") (openo "dates.org"))
(global-set-key (kbd "C-c o j") (openo "projects.org"))
(global-set-key (kbd "C-c o f") (openo "finance.org"))
(global-set-key (kbd "C-c o w") (openo "work/" t))
(global-set-key (kbd "C-c o o") (openo ".org" t))

(global-set-key (kbd "C-c o c") (fni (org-clock-jump-to-current-clock)))
(global-set-key (kbd "C-c o C") 'org-contacts)

(provide 'init-org/shortcuts)
