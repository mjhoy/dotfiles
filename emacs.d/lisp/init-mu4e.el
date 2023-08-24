;; mu4e is a little different in that it comes packages with `mu`, so
;; it doesn't live in my .emacs.d repository or in a package
;; repository. therefore check whether it is present before loading.
(defvar mjhoy/mu4e-load-path
  "/usr/local/share/emacs/site-lisp/mu4e"
  "Load path for my mu4e install")

;; nix bug?
(if nixos
    (add-to-list 'load-path "/run/current-system/sw/share/emacs/site-lisp/mu4e"))

(add-to-list 'load-path (expand-file-name "~/.nix-profile/share/emacs/site-lisp/mu4e"))

(defvar mjhoy/mu4e-exists-p
  (locate-file "mu4e.el" load-path)
  "Whether mu4e exists on this system")

(if mjhoy/mu4e-exists-p
    (progn
      ;; mu4e exists on this system
      (require 'mu4e)

      (setq mu4e-maildir-shortcuts
            '(
              ("/mjh-mjhoy.com/INBOX" . ?i)
              ("/mjh-mjhoy.com/upcoming" . ?u)
              ("/michael.john.hoy-gmail.com/INBOX" . ?g)
              ("/mjh-mjhoy.com/Archive" . ?a)
              ("/mjh-mjhoy.com/massbird" . ?m)
              ("/mjh-mjhoy.com/Drafts" . ?d)
              ("/mjh-mjhoy.com/Sent Items" . ?s)
              ("/mjh-mjhoy.com/Trash" . ?t)
              ))

      (setq mail-user-agent 'mu4e-user-agent)
      (setq mu4e-view-show-addresses t)
      (setq mu4e-headers-include-related t)

      ;; we don't save sent mail with gmail, so just use fastmail as default
      (setq mu4e-sent-folder "/mjh-mjhoy.com/Sent Items")

      ;; `check-inbox` is a wrapper script for offlineimap
      (setq mu4e-get-mail-command "~/bin/check-inbox")

      ;; Personal email setup
      (setq mu4e-sent-messages-behavior 'sent)
      (setq message-send-mail-function 'smtpmail-send-it
            starttls-use-gnutls t
            smtpmail-starttls-credentials
            '(("mail.messagingengine.com" 587 nil nil))
            smtpmail-default-smtp-server "mail.messagingengine.com"
            smtpmail-smtp-server "mail.messagingengine.com"
            smtpmail-auth-credentials
            (expand-file-name "~/.authinfo.gpg")
            smtpmail-smtp-service 587)
      (setq message-kill-buffer-on-exit t)
      (setq mu4e-compose-signature-auto-include nil)
      (setq mu4e-refile-folder "/mjh-mjhoy.com/Archive")
      (setq mu4e-drafts-folder "/mjh-mjhoy.com/Drafts")
      (setq mu4e-sent-folder "/mjh-mjhoy.com/Sent Items")
      (setq mu4e-trash-folder "/mjh-mjhoy.com/Trash")
      (setq smtpmail-starttls-credentials
            '(("mail.messagingengine.com" 587 nil nil))
            smtpmail-default-smtp-server "mail.messagingengine.com"
            smtpmail-smtp-server "mail.messagingengine.com"
            )
      (setq user-mail-address "mjh@mjhoy.com")

      (setq mu4e-compose-complete-ignore-address-regexp "\\(no-?reply\\|reply.github.com\\|basecamphq.com\\)")

      ;; rich text messages: use eww
      ;; (setq mu4e-html2text-command "html2text -utf8 -nobs -width 72")
      (require 'mu4e-contrib)
      (setq mu4e-html2text-command 'mu4e-shr2text)

      (setq org-mu4e-link-query-in-headers-mode nil)

      ;; bookmarks
      (add-to-list 'mu4e-bookmarks '("date:14d..now AND maildir:/michael.john.hoy-gmail.com/archive"  "Latest archive" ?a))
      (add-to-list 'mu4e-bookmarks '("date:14d..now AND maildir:/michael.john.hoy-gmail.com/sent"     "Latest sent"    ?s))
      (add-to-list 'mu4e-bookmarks '("size:5M..500M"                       "Big messages"   ?b))

      (setq mu4e-attachment-dir  "~/Downloads/email")

      ;; use built-in emacs completing read function
      (setq mu4e-completing-read-function 'completing-read)

      ;; confirm sending messages
      (add-hook 'message-send-hook
                (lambda ()
                  (unless (yes-or-no-p "Sure you want to send this? ")
                    (signal 'quit nil))))

      (setq mu4e-headers-fields '((:human-date . 12)
                                  ;; (:maildir . 16) ; TODO: possible to make look good?
                                  (:flags . 6)
                                  (:mailing-list . 6)
                                  (:from . 18)
                                  (:thread-subject)))
      (setq mu4e-use-fancy-chars nil)

      (defun mjhoy/compose-mode-setup ()
        "Run when composing a message."
        (setq truncate-lines nil)
        (visual-line-mode)
        (set-fill-column 72)        ; 72 chars wide
        (flyspell-mode))            ; correctly spelled

      (defun mjhoy/view-mode-setup ()
        "Run when viewing a message."
        (setq truncate-lines nil)
        (visual-line-mode))

      ;; Compose/view setup
      (add-hook 'mu4e-compose-mode-hook 'mjhoy/compose-mode-setup)
      (add-hook 'mu4e-view-mode-hook 'mjhoy/view-mode-setup)

      (defun mjhoy/mu4e-quick-check (run-in-background)
        "Check email inboxes and update mu4e index"
        (interactive "P")
        (let ((mu4e-get-mail-command "~/bin/check-inbox-quick"))
          (mu4e-update-mail-and-index run-in-background)))
      (define-key mu4e-main-mode-map "u" 'mjhoy/mu4e-quick-check)
      (define-key mu4e-main-mode-map "n" 'next-line)
      (define-key mu4e-main-mode-map "p" 'previous-line)

      (if (boundp 'org-directory)
          (progn
            (setq mu4e-org-contacts-file (concat org-directory "contacts.org"))
            (add-to-list 'mu4e-headers-actions
                         '("org-contact-add" . mu4e-action-add-org-contact) t)
            (add-to-list 'mu4e-view-actions
                         '("org-contact-add" . mu4e-action-add-org-contact) t)))

      (add-to-list 'mu4e-view-actions
                   '("ViewInBrowser" . mu4e-action-view-in-browser) t)
      )
  )

(provide 'init-mu4e)
