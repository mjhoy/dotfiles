(setq org-agenda-files
      (mapcar
       (function (lambda (f) (file-truename (concat org-directory f))))
       (list "inbox.org"                ; anything not yet organized
             "dates.org"                ; upcoming dates
             "projects.org"             ; stuff i'm working on
             "finance.org"              ; personal finances
             )))

(setq org-refile-targets
      `((,(concat org-directory "projects.org") :level . 1)))

;; auto-save org buffers after refiling
(defun mjhoy/save-org-agenda-buffers ()
  "Save `org-agenda-files' buffers without user confirmation."
  (interactive)
  (message "Saving org-agenda-files buffers...")
  (save-some-buffers t (lambda ()
                         (when (member (buffer-file-name) org-agenda-files)
                           t)))
  )

(advice-add 'org-refile :after
            (lambda (&rest _)
              (mjhoy/save-org-agenda-buffers)))

;; the "Project" view. adapted from the agenda setup here:
;; https://www.labri.fr/perso/nrougier/GTD/index.html#org8c6ecc6
(setq org-agenda-custom-commands
      '(("j" "Projects"
         ((agenda ""
                  ((org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'deadline))
                   (org-deadline-warning-days 0)))
          (todo "NEXT"
                ((org-agenda-skip-function
                  '(org-agenda-skip-entry-if 'deadline))
                 (org-agenda-prefix-format "  %i %-12:c [%e] ")
                 (org-agenda-overriding-header "\nTasks\n")))
          (agenda nil
                  ((org-agenda-entry-types '(:deadline))
                   (org-agenda-format-date "")
                   (org-deadline-warning-days 7)
                   (org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'notregexp "\\* NEXT"))
                   (org-agenda-overriding-header "\nDeadlines")))
          (tags-todo "inbox"
                     ((org-agenda-prefix-format "  %?-12t% s")
                      (org-agenda-overriding-header "\nInbox\n")))
          (tags "CLOSED>=\"<today>\""
                ((org-agenda-overriding-header "\nCompleted today\n")))))))

(setq org-agenda-dim-blocked-tasks nil)

(setq org-agenda-sticky t)

(setq org-habit-show-all-today t)

(provide 'init-org/agenda)
