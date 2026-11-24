;; nixos:
;;
;; emacs (when launched from the gui/xmonad) does not seem to connect
;; with my ssh-agent, and there may be other issues. i think that
;; perhaps exec-path-from-shell can solve my issues but i haven't
;; figured it out yet.
;;
;; attempt below, doesn't actually fix it.

;; package: 'exec-path-from-shell
;; (exec-path-from-shell-initialize)
;; (exec-path-from-shell-copy-env "INFOPATH")
;; (exec-path-from-shell-copy-env "NIX_PATH")
;; (exec-path-from-shell-copy-env "SSH_AGENT_PID")
;; (exec-path-from-shell-copy-env "SSH_ASKPASS")
;; (exec-path-from-shell-copy-env "SSH_AUTH_SOCK")

(provide 'init-env)
