(defun mjhoy/open-org-notebook (filename)
  (find-file (concat org-directory filename)))

(defmacro openo (&rest forms)
  `(fni (mjhoy/open-org-notebook ,@forms)))

(global-set-key (kbd "C-c o o") (openo "organizer.org"))
(global-set-key (kbd "C-c o a") (openo "organizer_archive.org"))
(global-set-key (kbd "C-c o p") (openo "programming_notes.org"))
(global-set-key (kbd "C-c o b") (openo "belch.org"))
(global-set-key (kbd "C-c o d") (openo "dates.org"))
(global-set-key (kbd "C-c o j") (openo "projects.org"))

(global-set-key (kbd "C-c o ?") (fni (let ((default-directory org-directory))
                                       (helm-find-files nil))))

(global-set-key (kbd "C-c o c") 'org-clock-jump-to-current-clock)
(global-set-key (kbd "C-c o C") 'org-contacts)

(provide 'init-org/shortcuts)
