(setq org-agenda-files
      (mapcar
       (function (lambda (f) (concat org-directory f)))
       (list "organizer.org"            ; main work/life todos
             "inbox.org"                ; anything not yet organized
             "dates.org"                ; upcoming dates
             "projects.org"             ; personal project notes
             "finance.org"              ; personal finances
             )))

(setq org-agenda-dim-blocked-tasks nil)

(setq org-agenda-sticky t)

(setq org-habit-show-all-today t)

(provide 'init-org/agenda)
