(defun mjhoy/open-org-notebook (filename &optional use-completion)
  (let ((find-func (if use-completion #'counsel-find-file #'find-file)))
    (funcall find-func (concat org-directory filename))))

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
(global-set-key (kbd "C-c o ?") (openo "" t))

(global-set-key (kbd "C-c o c") (fni (org-clock-jump-to-current-clock)))
(global-set-key (kbd "C-c o C") 'org-contacts)

(provide 'init-org/shortcuts)
