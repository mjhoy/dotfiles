(require 'init-basic)

(mjhoy/require-package 'org-plus-contrib)
(mjhoy/require-package 'org-mime)

;; needs to be set before org is loaded.
(setq org-export-backends '(ascii html md latex odt))

(require 'org)
(require 'org-mime)
(require 'org-id)
(require 'org-clock)
(require 'org-habit)

;; for HTML export
(mjhoy/require-package 'htmlize)

(setq org-id-link-to-org-use-id 'use-existing)

(setq org-startup-indented t)

(setq org-directory "~/org/")

(setq org-default-notes-file (concat org-directory "belch.org"))

(setq org-imenu-depth 5)

(setq org-list-allow-alphabetical t)

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

;; add a "digression" and "aside" template for writing
(add-to-list 'org-structure-template-alist
             '("d" "#+BEGIN_DIGRESSION\n?\n#+END_DIGRESSION" ""))
(add-to-list 'org-structure-template-alist
             '("as" "#+BEGIN_ASIDE\n?\n#+END_ASIDE" ""))

;; Makes an entry for an invoice with some basic info filled in.
(defun mjhoy/org-generate-invoice-item ()
  "Inserts an invoice headline."
  (interactive)
  (progn
    (org-insert-heading)
    (insert "Invoice #")
    (insert (format-time-string "%Y%m%d01"))
    (org-id-get-create)
    (org-insert-heading-respect-content)
    (org-demote)
    (insert "Timesheet")
    ))

;; abbrevs
(define-abbrev org-mode-abbrev-table "\l" "\lambda")
(define-abbrev org-mode-abbrev-table "\lra" "\leftrightarrow")

;; org-mode hook
(defun mjhoy/org-mode-hook ()
  "My org-mode-hook function."
  (auto-fill-mode 1))

(add-hook 'org-mode-hook 'mjhoy/org-mode-hook)

(require 'init-org/contacts)
(require 'init-org/agenda)
(require 'init-org/shortcuts)
(require 'init-org/todo)
(require 'init-org/code)
(require 'init-org/captures)
(require 'init-org/bindings)

(provide 'init-org)
