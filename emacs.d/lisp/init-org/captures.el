(require 'org-id)

(defun mjhoy/current-journal-file ()
  "Absolute path to my current journal entry for today."
  (format (expand-file-name "~/journal/%s.org") (format-time-string "%Y-%m-%d")))

;; Create a unique id for all captures.
(add-hook 'org-capture-prepare-finalize-hook 'org-id-get-create)

(setq org-capture-templates
      '(("t" "Todo"
         entry (file+headline (lambda () (concat org-directory "projects.org")) "general")
         "* TODO %?
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
         entry (file+headline (lambda () (concat org-directory "agenda.org")) "Future")
         "* %?
SCHEDULED: <%<%Y-%m-%d %a %H:00>>

see %a\n")
        ("j" "Journal"
         plain (file mjhoy/current-journal-file)
         "* %<%H:%M>\n%U\n\n%?\n")
        ))

(provide 'init-org/captures)
