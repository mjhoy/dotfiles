(require 'erc)

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

(global-set-key (kbd "C-c e f") 'mjhoy/freenode-erc)

(setq erc-autojoin-channels-alist '(("freenode.net" "#emacs" "#drupal")))

(provide 'init-erc)
