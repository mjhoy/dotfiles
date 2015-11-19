(require 'erc)
(require 'init-basic)

(defun mjhoy/freenode-erc ()
  "Connect to freenode with my account

Requires ~/.authinfo.gpg to contain a line like so,

machine irc.freenode.net login LOGIN password PASSWORD
"
  (interactive)
  (let* ((server      "irc.freenode.net")
         (port        "6697")
         (credentials (auth-source-search :machine server
                                          :max-tokens 1))
         (password (funcall (plist-get (car credentials) :secret))))
    (erc-tls :server server
             :port port
             :nick "mjhoy"
             :password password)))

(global-set-key (kbd "C-c i c") 'mjhoy/freenode-erc)

(setq erc-hide-list '("JOIN" "PART" "QUIT"))

(setq erc-server-reconnect-timeout 4)

;; channel shortcuts
(global-set-key (kbd "C-c i j h") (fni (erc-join-channel "#haskell")))
(global-set-key (kbd "C-c i j e") (fni (erc-join-channel "#emacs")))
(global-set-key (kbd "C-c i j o") (fni (erc-join-channel "#org-mode")))
(global-set-key (kbd "C-c i j d") (fni (erc-join-channel "#drupal")))
(global-set-key (kbd "C-c i j n") (fni (erc-join-channel "#nixos")))
(global-set-key (kbd "C-c i j N") (fni (erc-join-channel "##nix-darwin")))
(global-set-key (kbd "C-c i j s") (fni (erc-join-channel "#snapframework")))

;; minimal distraction: only track when i am mentioned
(setq erc-format-query-as-channel-p t
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
