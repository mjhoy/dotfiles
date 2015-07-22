(require 'erc)
(require 'init-basic)

(defun mjhoy/freenode-erc ()
  "Connect to freenode with my account

Requires ~/.authinfo.gpg to contain a line like so,

machine irc.freenode.net login LOGIN password PASSWORD
"
  (interactive)
  (let* ((server      "irc.freenode.net")
         (port        "6667")
         (credentials (auth-source-search :machine server
                                          :max-tokens 1))
         (password (funcall (plist-get (car credentials) :secret))))
    (erc :server "irc.freenode.net"
         :port "6667"
         :nick "mjhoy"
         :password password)))

(global-set-key (kbd "C-c e c") 'mjhoy/freenode-erc)

;; channel shortcuts
(global-set-key (kbd "C-c e j h") (fni (erc-join-channel "#haskell")))
(global-set-key (kbd "C-c e j e") (fni (erc-join-channel "#emacs")))
(global-set-key (kbd "C-c e j d") (fni (erc-join-channel "#drupal")))
(global-set-key (kbd "C-c e j n") (fni (erc-join-channel "#nixos")))

(provide 'init-erc)
