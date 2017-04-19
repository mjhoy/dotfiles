(setq org-agenda-files
      (mapcar
       (function (lambda (f) (concat org-directory f)))
       (list "organizer.org"            ; main work/life todos
             "belch.org"                ; all notes go here
             "dates.org"                ; upcoming dates
             "projects.org"             ; personal project notes
             "finance.org"              ; personal finances
             "habits.org"               ; org habits
             "programming_notes.org"    ; programming notebook
             )))

(setq org-agenda-dim-blocked-tasks nil)

(setq org-agenda-sticky t)

(provide 'init-org/agenda)
