(require 'mu4e)

(defun mjhoy/switch-to-fastmail ()
  "Switch to my fastmail config."
  (interactive)
  (setq mu4e-sent-messages-behavior 'sent)
  (setq mu4e-refile-folder "/mjh-mjhoy.com/INBOX.Archive")
  (setq smtpmail-starttls-credentials
        '(("mail.messagingengine.com" 587 nil nil))
        smtpmail-default-smtp-server "mail.messagingengine.com"
        smtpmail-smtp-server "mail.messagingengine.com"
        )
  (setq user-mail-address "mjh@mjhoy.com")
  )

(defun mjhoy/switch-to-gmail ()
  "Switch to my gmail config."
  (interactive)
  (setq mu4e-sent-messages-behavior 'delete)
  (setq mu4e-refile-folder nil)
  (setq smtpmail-starttls-credentials
        '(("smtp.gmail.com" 587 nil nil))
        smtpmail-default-smtp-server "smtp.gmail.com"
        smtpmail-smtp-server "smtp.gmail.com")
  (setq user-mail-address "michael.john.hoy@gmail.com")
  )

(setq mu4e-maildir-shortcuts
      '(
        ("/mjh-mjhoy.com/INBOX" . ?i)
        ("/michael.john.hoy-gmail.com/INBOX" . ?g)
        ("/mjh-mjhoy.com/INBOX.Archive" . ?a)
        ("/mjh-mjhoy.com/INBOX.Trash" . ?t)
         ))

(setq mu4e-mu-binary "/usr/local/bin/mu")
(setq mail-user-agent 'mu4e-user-agent)
(setq mu4e-maildir "~/.mail/")
(setq mu4e-drafts-folder "/drafts")

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

;; rich text messages: use eww
;; (setq mu4e-html2text-command "html2text -utf8 -nobs -width 72")
(require 'mu4e-contrib)
(setq mu4e-html2text-command 'mu4e-shr2text)
;; org-mode: this allows me to capture links to email messages
(require 'org-mu4e)
;; bookmarks
(add-to-list 'mu4e-bookmarks '("date:14d..now AND maildir:/michael.john.hoy-gmail.com/archive"  "Latest archive" ?a))
(add-to-list 'mu4e-bookmarks '("date:14d..now AND maildir:/michael.john.hoy-gmail.com/sent"     "Latest sent"    ?s))
(add-to-list 'mu4e-bookmarks '("size:5M..500M"                       "Big messages"   ?b))

(setq mu4e-attachment-dir  "~/Downloads")

;; confirm sending messages
(add-hook 'message-send-hook
  (lambda ()
    (unless (yes-or-no-p "Sure you want to send this? ")
      (signal 'quit nil))))

;; Compose/view setup
(add-hook 'mu4e-compose-mode-hook
          (lambda ()
            (mjhoy/proportional)        ; proportional font,
            (set-fill-column 72)        ; 72 chars wide,
            (flyspell-mode)))           ; correctly spelled
(add-hook 'mu4e-view-mode-hook 'mjhoy/proportional)
