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

      (defun mjhoy/remind-no-d-key ()
        (interactive)
        (message "No deleting [d] while in fastmail setup; use [m t]"))

      (defun mjhoy/switch-to-personal-email ()
        "Switch to my personal config."
        (interactive)
        (setq mu4e-sent-messages-behavior 'sent)
        (setq mu4e-refile-folder "/mjh-mjhoy.com/INBOX.Archive")
        (setq mu4e-drafts-folder "/mjh-mjhoy.com/INBOX.Drafts")
        (setq mu4e-sent-folder "/mjh-mjhoy.com/INBOX.Sent Items")
        (setq mu4e-trash-folder "/trash")
        (setq smtpmail-starttls-credentials
              '(("mail.messagingengine.com" 587 nil nil))
              smtpmail-default-smtp-server "mail.messagingengine.com"
              smtpmail-smtp-server "mail.messagingengine.com"
              )
        (setq user-mail-address "mjh@mjhoy.com")
        )

      (defun mjhoy/switch-to-work-email ()
        "Switch to my work config."
        (interactive)
        (setq mu4e-sent-messages-behavior 'delete)
        (setq mu4e-refile-folder nil)
        (setq mu4e-drafts-folder "/freebird/drafts")
        (setq mu4e-trash-folder "/trash")
        (setq smtpmail-starttls-credentials
              '(("smtp.gmail.com" 587 nil nil))
              smtpmail-default-smtp-server "smtp.gmail.com"
              smtpmail-smtp-server "smtp.gmail.com")
        (setq user-mail-address "mikey@getfreebird.com")
        )

      (defvar mjhoy/switch-mail-auto nil
        "Switch work/personal automatically in mu4e.")

      (defun mjhoy/switch-mail-auto-fn ()
        "Automatically switch mailboxes based on parent message"
        (let ((msg mu4e-compose-parent-message))
          (when msg
            (cond
             ((not mjhoy/switch-mail-auto)
              '())
             ((or
               (mu4e-message-contact-field-matches msg :to "getfreebird.com")
               (mu4e-message-contact-field-matches msg :from "mikey@getfreebird.com")
               (mu4e-message-contact-field-matches msg :cc "getfreebird.com")
               (mu4e-message-contact-field-matches msg :bcc "getfreebird.com"))
              (mjhoy/switch-to-work-email))
             ((or
               (mu4e-message-contact-field-matches msg :to "mjhoy.com")
               (mu4e-message-contact-field-matches msg :from "mjh@mjhoy.com")
               (mu4e-message-contact-field-matches msg :cc "mjhoy.com")
               (mu4e-message-contact-field-matches msg :bcc "mjhoy.com")
               (mu4e-message-contact-field-matches msg :to "michael.john.hoy@gmail.com")
               (mu4e-message-contact-field-matches msg :cc "michael.john.hoy@gmail.com")
               (mu4e-message-contact-field-matches msg :bcc "michael.john.hoy@gmail.com"))
              (mjhoy/switch-to-personal-email))
             (t
              '())))))

      (add-hook 'mu4e-compose-pre-hook 'mjhoy/switch-mail-auto-fn)

      (setq mu4e-maildir-shortcuts
            '(
              ("/mjh-mjhoy.com/INBOX" . ?i)
              ("/freebird/INBOX" . ?w)
              ("/michael.john.hoy-gmail.com/INBOX" . ?g)
              ("/mjh-mjhoy.com/INBOX.Archive" . ?a)
              ("/mjh-mjhoy.com/INBOX.Drafts" . ?d)
              ("/mjh-mjhoy.com/INBOX.Sent Items" . ?s)
              ("/mjh-mjhoy.com/INBOX.Trash" . ?t)
              ))

      (setq mail-user-agent 'mu4e-user-agent)
      (setq mu4e-maildir "~/.mail/")
      (setq mu4e-view-show-addresses t)
      (setq mu4e-headers-include-related t)

      (setq mu4e-user-mail-address-list '("mjh@mjhoy.com"
                                          "mikey@getfreebird.com"))

      ;; we don't save sent mail with gmail, so just use fastmail as default
      (setq mu4e-sent-folder "/mjh-mjhoy.com/INBOX.Sent Items")

      ;; `check-inbox` is a wrapper script for offlineimap
      (setq mu4e-get-mail-command "~/bin/check-inbox")

      ;; Set up for my fastmail config initially
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

      (mjhoy/switch-to-personal-email)

      ;; work computer
      (if (string-match "michaelymacbook" system-name)
          (mjhoy/switch-to-work-email))

      (setq mu4e-compose-complete-ignore-address-regexp "\\(no-?reply\\|reply.github.com\\|basecamphq.com\\)")

      ;; rich text messages: use eww
      ;; (setq mu4e-html2text-command "html2text -utf8 -nobs -width 72")
      (require 'mu4e-contrib)
      (setq mu4e-html2text-command 'mu4e-shr2text)
      ;; org-mode: this allows me to capture links to email messages
      (require 'org-mu4e)

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
