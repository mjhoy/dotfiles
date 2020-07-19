(defun mjhoy/open-org-notebook (filename &optional use-helm)
  (let ((find-func #'counsel-find-file))
    (funcall find-func (concat org-directory filename))))

(defmacro openo (&rest forms)
  `(fni (mjhoy/open-org-notebook ,@forms)))

(global-set-key (kbd "C-c o o") (openo "organizer.org"))
(global-set-key (kbd "C-c o a") (openo "organizer_archive.org"))
(global-set-key (kbd "C-c o p") (openo "programming_notes/" t))
(global-set-key (kbd "C-c o r") (openo "reading_notes.org"))
(global-set-key (kbd "C-c o b") (openo "belch.org"))
(global-set-key (kbd "C-c o d") (openo "dates.org"))
(global-set-key (kbd "C-c o j") (openo "projects.org"))
(global-set-key (kbd "C-c o f") (openo "finance.org"))
(global-set-key (kbd "C-c o w") (openo "work/" t))

(global-set-key (kbd "C-c o ?") (fni (let ((default-directory org-directory))
                                       (helm-find-files nil))))

(global-set-key (kbd "C-c o c") (fni (org-clock-jump-to-current-clock)))
(global-set-key (kbd "C-c o C") 'org-contacts)

(provide 'init-org/shortcuts)
