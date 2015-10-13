(require 'init-basic)

(mjhoy/require-package 'org-plus-contrib)

(require 'org)
(require 'org-mime)

(setq org-directory "~/Dropbox/org/")

(setq org-default-notes-file (concat org-directory "belch.org"))

(setq org-imenu-depth 5)

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

;; add a "digression" template
(add-to-list 'org-structure-template-alist
             '("d" "#+BEGIN_DIGRESSION\n?\n#+END_DIGRESSION" ""))

(require 'init-org/contacts)
(require 'init-org/agenda)
(require 'init-org/shortcuts)
(require 'init-org/todo)
(require 'init-org/code)
(require 'init-org/captures)
(require 'init-org/bindings)

(provide 'init-org)
