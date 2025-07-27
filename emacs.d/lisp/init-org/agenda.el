(setopt org-agenda-files
      (mapcar
       (function (lambda (f) (file-truename (concat org-directory f))))
       (list "inbox.org"                ; anything not yet organized
             "agenda.org"               ; scheduled/deadlines
             "dates.org"                ; upcoming dates
             "projects.org"             ; stuff i'm working on
             "finance.org"              ; personal finances
             )))

(setopt org-refile-targets
      `((,(concat org-directory "projects.org") :level . 1)))

(setopt org-agenda-span 'day)

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

(setopt org-agenda-custom-commands
        '(
          ;; List all done or canceled tasks.
          ;; TODO: is there a way to organize this by date completed/canceled?
          ("c" "Completed tasks"
           ((todo "DONE|CANCELED")))
          ;; the "Project" view. adapted from the agenda setup here:
          ;; https://www.labri.fr/perso/nrougier/GTD/index.html#org8c6ecc6
          ("j" "Projects"
           ((agenda ""
                    ((org-agenda-skip-function
                      '(org-agenda-skip-entry-if 'deadline))
                     (org-deadline-warning-days 0)))
            (todo "NEXT|REVIEW|DEPLOY"
                  ((org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'deadline 'scheduled))
                   (org-agenda-prefix-format "  %i %-12:c [%e] ")
                   (org-agenda-overriding-header "\nNext\n")))
            (agenda ""
                    ((org-agenda-entry-types '(:deadline))
                     (org-agenda-format-date "")
                     (org-deadline-warning-days 7)
                     (org-agenda-skip-function
                      '(org-agenda-skip-entry-if 'nottodo '("TODO" "NEXT")))
                     (org-agenda-overriding-header "\nDeadlines")))
            (agenda ""
                    ((org-agenda-entry-types '(:scheduled))
                     (org-deadline-warning-days 7)
                     (org-agenda-skip-function
                      '(org-agenda-skip-entry-if 'nottodo '("TODO" "NEXT")))
                     (org-agenda-overriding-header "\nScheduled")))
            (tags "inbox"
                  ((org-agenda-prefix-format "  %?-12t% s")
                   (org-agenda-overriding-header "\nInbox\n")))
            (tags "CLOSED>=\"<today>\""
                  ((org-agenda-overriding-header "\nCompleted today\n")))))))

(setopt org-agenda-dim-blocked-tasks nil)

(setopt org-agenda-sticky t)

(setopt org-habit-show-all-today nil)
(setopt org-habit-show-habits-only-for-today nil)

(provide 'init-org/agenda)
