(mjhoy/require-package 'org)

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

(defun mjhoy/open-organizer ()
  (interactive)
  (find-file (concat org-directory "organizer.org")))

(global-set-key (kbd "C-c o") 'mjhoy/open-organizer)

(setq org-default-notes-file (concat org-directory "belch.org"))

(setq org-capture-templates
      '(("t" "Todo"
         entry (file+headline (concat org-directory "organizer.org") "General")
         "* TODO %?\n  %i\n  %a")
        ("n" "Note"
         entry (file (concat org-directory "belch.org"))
         "* %?\n%U\n%a")
        ("c" "Clock" item (clock)
         "%?\n%U\n%a")
        ("q" "Clock (quick)" plain (clock)
         "%a%?")
        ("s" "Emacs tool sharpening"
         entry (file+olp (concat org-directory "programming_notes.org")
                         "Emacs"
                         "Sharpening list")
         "* %?\nsee %a\nentered on %U")
        ("S" "General tool sharpening"
         entry (file+olp (concat org-directory "programming_notes.org")
                         "General sharpening")
         "* %?\nsee %a\nentered on %U")
        ("d" "Date"
         entry (file+datetree+prompt (concat org-directory "dates.org"))
         "* %?\n%t\n\nsee %a")
        ("j" "Journal"
         plain (file+datetree (concat org-directory "journal.org"))
         "%?\nEntered on %U")
        ("r" "Dream"
         plain (file+datetree (concat org-directory "dream.org"))
         "%?\n")
        ("e" "Engineering journal"
         plain (file+datetree (concat org-directory "eng_journal.org"))
         "%?\nEntered on %U")
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
  (interactive)
  (org-sort-entries nil ?o)
  (org-cycle)                           ; fold children?
  (org-cycle))
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

(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c l") 'org-store-link)

(provide 'init-org)
