(require 'org-id)

(defun mjhoy/current-journal-file ()
  "Absolute path to my current journal entry for today."
  (format (expand-file-name "~/journal/%s.org") (format-time-string "%Y-%m-%d")))

;; Create a unique id for all captures.
(add-hook 'org-capture-prepare-finalize-hook 'org-id-get-create)

(setopt org-capture-templates
        '(("T" "Todo (today)"
           entry (file+headline (lambda () (concat org-directory "projects.org")) "general")
           "* TODO [#B] %^{Todo} %^g
SCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"\"))
:LOGBOOK:
- State \"TODO\"       from \"\"           %U
:END:

see: %a\n")
          ("t" "Todo"
           entry (file+headline (lambda () (concat org-directory "projects.org")) "general")
           "* TODO [#B] %^{Todo} %^g
:LOGBOOK:
- State \"TODO\"       from \"\"           %U
:END:

see: %a\n")
          ("i" "Inbox"
           entry (file (lambda () (concat org-directory "inbox.org")))
           "* %?
%U\n%a\n")
          ("c" "Clock" item (clock)
           "%?\n%U\n%a")
          ("e" "Event"
           entry (file+olp+datetree (lambda () (concat org-directory "agenda.org")) "Events")
           "* %?
<%<%Y-%m-%d %a %H:00>>

see %a\n" :time-prompt t)
          ("b" "Blog draft"
           entry (file (lambda () (concat org-directory "blog-drafts.org")))
           "* draft: %?
\n")
          ("j" "Journal"
           plain (file mjhoy/current-journal-file)
           "* %<%H:%M>\n%U\n\n%?\n")
          ("w" "Week in review"
           plain (file mjhoy/current-journal-file)
           "* %<%H:%M> Week in review (%<%U>)\n%U\n%?\n** Programming\n** People\n** Job\n** Climbing\n** House\n")
          ))

(provide 'init-org/captures)
