(require 'org-id)

;; Create a unique id for all captures.
(add-hook 'org-capture-prepare-finalize-hook 'org-id-get-create)

(setq org-capture-templates
      '(("t" "Todo"
         entry (file+headline (lambda () (concat org-directory "organizer.org")) "General")
         "* TODO %?
DEADLINE: %t
:LOGBOOK:
- State \"TODO\"       from \"\"           %U
:END:

see: %a\n")
        ("n" "Note"
         entry (file (lambda () (concat org-directory "belch.org")))
         "* %?
%U\n%a\n")
        ("c" "Clock" item (clock)
         "%?\n%U\n%a")
        ("C" "Contact" entry (file (lambda () (concat org-directory "contacts.org")))
         "* %(org-contacts-template-name)
:PROPERTIES:
:EMAIL: %(org-contacts-template-email)
:END:\n")
        ("b" "Book" entry (file (lambda () (concat org-directory "lists/books.org")))
         "* %?
(C-c C-w to refile to fiction/non-fiction)
see %a
entered on %U\n")
        ("q" "Clock (quick)" plain (clock)
         "%a%?\n")
        ("s" "Emacs tool sharpening"
         entry (file+olp (lambda () (concat org-directory "programming_notes.org"))
                         "Emacs"
                         "Sharpening list")
         "* %?
see %a
entered on %U\n")
        ("S" "General tool sharpening"
         entry (file+olp (lambda () (concat org-directory "programming_notes.org"))
                         "General sharpening")
         "* %?
see %a
entered on %U\n")
        ("d" "Date"
         entry (file+datetree+prompt (lambda () (concat org-directory "dates.org")))
         "* %?
%t

see %a\n")
        ("j" "Journal"
         plain (file+datetree (lambda () (concat org-directory "journal.org")))
         "**** <title>\n%U\n\n%?\n")
        ("r" "Dream"
         plain (file+datetree (lambda () (concat org-directory "dream.org")))
         "%?\n")
        ("e" "Engineering journal"
         plain (file+datetree (lambda () (concat org-directory "eng_journal.org")))
         "%?\nEntered on %U\n")
        ))

(provide 'init-org/captures)
