(require 'erc)
(require 'init-basic)
(require 'erc-truncate)

(defun mjhoy/libera-erc ()
  "Connect to libera.chat with my account

Requires ~/.authinfo.gpg to contain a line like so,

machine irc.libera.chat login LOGIN password PASSWORD
"
  (interactive)
  (let* ((server      "irc.libera.chat")
         (port        "6697")
         (credentials (auth-source-search :host server
                                          :max-tokens 1))
         (password (funcall (plist-get (car credentials) :secret))))
    (erc-tls :server server
             :port port
             :nick "mjhoy"
             :password password)))

(defun mjhoy/mozilla-erc ()
  "Connect to mozilla irc with my account"
  (interactive)
  (let* ((server      "irc.mozilla.org")
         (port        "6697"))
    (erc-tls :server server
             :port port
             :nick "mjhoy")))

(global-set-key (kbd "C-c i c") 'mjhoy/libera-erc)

(setopt erc-hide-list '("JOIN" "PART" "QUIT"))

(setopt erc-server-reconnect-timeout 4)

;; channel shortcuts
(global-set-key (kbd "C-c i j h") (fni (erc-join-channel "#haskell")))
(global-set-key (kbd "C-c i j p") (fni (erc-join-channel "#purescript")))
(global-set-key (kbd "C-c i j e") (fni (erc-join-channel "#emacs")))
(global-set-key (kbd "C-c i j o") (fni (erc-join-channel "#org-mode")))
(global-set-key (kbd "C-c i j d") (fni (erc-join-channel "#drupal")))
(global-set-key (kbd "C-c i j n") (fni (erc-join-channel "#nixos")))
(global-set-key (kbd "C-c i j N") (fni (erc-join-channel "##nix-darwin")))
(global-set-key (kbd "C-c i j s") (fni (erc-join-channel "#snapframework")))

;; minimal distraction: only track when i am mentioned
(setopt erc-format-query-as-channel-p t
      erc-track-priority-faces-only 'all
      erc-track-faces-priority-list '(erc-error-face
                                      erc-current-nick-face
                                      erc-keyword-face
                                      erc-nick-msg-face
                                      erc-direct-msg-face
                                      erc-dangerous-host-face
                                      erc-notice-face
                                      erc-prompt-face))

(provide 'init-erc)
