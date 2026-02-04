(require 'org-id)

(defun mjhoy/current-journal-file ()
  "Absolute path to my current journal entry for today."
  (format (expand-file-name "~/journal/%s.org") (format-time-string "%Y-%m-%d")))

(defun mjhoy/org-get-people-list ()
  "Extract all level 1 headings from people.org as a list of person names."
  (let (people)
    (with-current-buffer (find-file-noselect (concat org-directory "people.org"))
      (org-with-wide-buffer
       (goto-char (point-min))
       (while (re-search-forward "^\\* \\(.+\\)$" nil t)
         (push (match-string-no-properties 1) people))))
    (nreverse people)))

(defun mjhoy/org-capture-person-heading ()
  "Navigate to a person's heading in people.org.
Prompts for person name with completion and positions at end of the person's heading line."
  (let* ((people (mjhoy/org-get-people-list))
         (person (completing-read "Person: " people nil t)))
    (find-file (concat org-directory "people.org"))
    (goto-char (point-min))
    ;; Find the person's level 1 heading
    (unless (re-search-forward (concat "^\\* " (regexp-quote person) "$") nil t)
      (error "Person not found: %s" person))
    ;; Position at end of the person's heading line
    (org-back-to-heading t)
    (end-of-line)))

(defun mjhoy/org-capture-people-location (section)
  "Navigate to SECTION under a person's heading in people.org.
Prompts for person name with completion and navigates to the specified section."
  (let* ((people (mjhoy/org-get-people-list))
         (person (completing-read "Person: " people nil t)))
    (find-file (concat org-directory "people.org"))
    (goto-char (point-min))
    ;; Find the person's level 1 heading
    (unless (re-search-forward (concat "^\\* " (regexp-quote person) "$") nil t)
      (error "Person not found: %s" person))
    ;; Move to beginning of heading and then into the subtree
    (org-back-to-heading t)
    (let ((person-start (point))
          (person-end (save-excursion
                        (org-end-of-subtree t t)
                        (point))))
      ;; Start search from within the person's subtree, not at the heading itself
      (goto-char person-start)
      (forward-line 1)
      (unless (re-search-forward (concat "^\\*\\* " (regexp-quote section) "$") person-end t)
        (error "Section '%s' not found for %s" section person))
      ;; Go back to the section heading and position at end of line
      ;; org-capture will handle inserting the entry as a child
      (org-back-to-heading t)
      (end-of-line))))

;; Create a unique id for all captures.
(add-hook 'org-capture-prepare-finalize-hook 'org-id-get-create)

(setopt org-capture-templates
        '(("m" "1:1 Meeting note"
           entry (function (lambda () (mjhoy/org-capture-people-location "Meeting Notes")))
           "* %<%Y-%m-%d %a %H:%M> 1:1
:PROPERTIES:
:ID: %(org-id-new)
:END:

** Discussion
%?

** Action Items

see: %a\n"
           :prepend t :time-prompt t)
          ("a" "Todo for person"
           entry (function (lambda () (mjhoy/org-capture-person-heading)))
           "* TODO %^{Todo}
:LOGBOOK:
- State \"TODO\"       from \"\"           %U
:END:

%?

see: %a\n")
          ("t" "Todo"
           entry (file+headline (lambda () (concat org-directory "projects.org")) "general")
           "* TODO [#B] %^{Todo} %^g
:LOGBOOK:
- State \"TODO\"       from \"\"           %U
:END:

see: %a\n")
          ("y" "Todo (toda[y])"
           entry (file+headline (lambda () (concat org-directory "projects.org")) "general")
           "* TODO [#B] %^{Todo} %^g
SCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"\"))
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
