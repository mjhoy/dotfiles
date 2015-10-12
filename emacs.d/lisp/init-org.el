(require 'init-basic)

(mjhoy/require-package 'org-plus-contrib)

(require 'org)

(setq org-directory "~/Dropbox/org/")

(setq org-agenda-files
      (mapcar
       (function (lambda (f) (concat org-directory f)))
       (list "organizer.org"            ; main work/life todos
             "belch.org"                ; all notes go here
             "dates.org"                ; upcoming dates
             "projects.org"             ; personal project notes
             )))

(require 'org-contacts)

(setq org-contacts-files
      (list (concat org-directory "contacts.org")))
(setq org-contacts-icon-use-gravatar nil)

(setq org-confirm-babel-evaluate nil)

(require 'ob-sh)
; do I want 'ob-shell ?

(require 'ob-sql)

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

(setq org-default-notes-file (concat org-directory "belch.org"))

(setq org-capture-templates
      '(("t" "Todo"
         entry (file+headline (concat org-directory "organizer.org") "General")
         "* TODO %?
  SCHEDULED: %t
  :LOGBOOK:
  - State \"TODO\"       from \"\"           %U
  :END:

  see: %a\n")
        ("n" "Note"
         entry (file (concat org-directory "belch.org"))
         "* %?
  %U
  %a\n")
        ("c" "Clock" item (clock)
         "%?\n%U\n%a")
        ("C" "Contact" entry (file (concat org-directory "contacts.org"))
         "* %(org-contacts-template-name)
:PROPERTIES:
:EMAIL: %(org-contacts-template-email)
:END:\n")
        ("b" "Book" entry (file (concat org-directory "lists/books.org"))
         "* %?
  (C-c C-w to refile to fiction/non-fiction)
  see %a
  entered on %U\n")
        ("q" "Clock (quick)" plain (clock)
         "%a%?\n")
        ("s" "Emacs tool sharpening"
         entry (file+olp (concat org-directory "programming_notes.org")
                         "Emacs"
                         "Sharpening list")
         "* %?
  see %a
  entered on %U\n")
        ("S" "General tool sharpening"
         entry (file+olp (concat org-directory "programming_notes.org")
                         "General sharpening")
         "* %?
  see %a
  entered on %U\n")
        ("d" "Date"
         entry (file+datetree+prompt (concat org-directory "dates.org"))
         "* %?
  %t

  see %a\n")
        ("j" "Journal"
         plain (file+datetree (concat org-directory "journal.org"))
         "%?\nEntered on %U\n")
        ("r" "Dream"
         plain (file+datetree (concat org-directory "dream.org"))
         "%?\n")
        ("e" "Engineering journal"
         plain (file+datetree (concat org-directory "eng_journal.org"))
         "%?\nEntered on %U\n")
        ))

(setq org-enforce-todo-dependencies t)
(setq org-log-done 'time)
(setq org-log-note-clock-out nil)

(setq org-todo-keywords
      '((sequence "TODO(t!)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@!)")))
(setq org-log-into-drawer "LOGBOOK")

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

;; from https://lists.gnu.org/archive/html/emacs-orgmode/2012-02/msg00515.html
(defun org-summary-checkboxes ()
  "Switch entry to DONE when all sub-checkboxes are done, to TODO otherwise."
  (save-excursion
    (org-back-to-heading t)
    (let ((beg (point)) end)
      (end-of-line)
      (setq end (point))
      (goto-char beg)
      (if (re-search-forward "\\[\\([0-9]*%\\)\\]\\|\\[\\([0-9]*\\)/\\([0-9]*\\)\\]" end t)
          (if (match-end 1)
              (if (equal (match-string 1) "100%")
                  (org-todo 'done)
                (org-todo 'todo))
            (if (and (> (match-end 2) (match-beginning 2))
                     (equal (match-string 2) (match-string 3)))
                (org-todo 'done)
              (org-todo 'todo)))))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
(add-hook 'org-checkbox-statistics-hook 'org-summary-checkboxes)

(defun mjhoy/org-sort-todos ()
  "Sort entries by TODO status"
  (interactive)
  (org-sort-entries nil ?o)
  (outline-hide-leaves))
(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c 6") 'mjhoy/org-sort-todos)))

(add-hook 'org-store-link-functions 'org-eww-store-link)
(defun org-eww-store-link ()
  "Store a link to the url of a eww buffer."
  (when (eq major-mode 'eww-mode)
    (org-store-link-props
     :type "eww"
     :link (if (< emacs-major-version 25)
               eww-current-url
             (eww-current-url))
     :url (url-view-url t)
     :description (if (< emacs-major-version 25)
                      (or eww-current-title eww-current-url)
                    (or (plist-get eww-data :title)
                        (eww-current-url))))))

(setq org-imenu-depth 5)

;; fontify our code blocks
(setq org-src-fontify-natively t)

;; add a "digression" template
(add-to-list 'org-structure-template-alist
             '("d" "#+BEGIN_DIGRESSION\n?\n#+END_DIGRESSION" ""))
(add-to-list 'org-structure-template-alist
             '("hs" "#+BEGIN_SRC haskell\n?\n#+END_SRC" "<src lang=\"haskell\">\n?\n</src>"))
(add-to-list 'org-structure-template-alist
             '("rs" "#+BEGIN_SRC rust\n?\n#+END_SRC" "<src lang=\"rust\">\n?\n</src>"))
(add-to-list 'org-structure-template-alist
             '("sh" "#+BEGIN_SRC shell\n?\n#+END_SRC" "<src lang=\"shell\">\n?\n</src>"))

(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c l") 'org-store-link)

(provide 'init-org)
