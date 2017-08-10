(unless window-system
  (if (string-equal system-type "darwin")
      (progn
        (mjhoy/require-package 'pbcopy)
        (turn-on-pbcopy)
        (if (executable-find "reattach-to-user-namespace")
            (progn
              ;; HACK redefine this function to use reattach-to-user-namespace.
              ;;
              ;; See:
              ;; https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard/issues/53
              ;;
              ;; also: https://github.com/jkp/pbcopy.el/pull/3
              ;;
              ;; To use this, $ brew install reattach-to-user-namespace.
              (defun pbcopy-set-selection (type data)
                (when pbcopy-program
                  (let* ((process-connection-type nil)
                         (proc (start-process "pbcopy" nil "reattach-to-user-namespace"
                                              "pbcopy"
                                              "-selection" (symbol-name type))))
                    (process-send-string proc data)
                    (process-send-eof proc))))

              )
          )
        )
    )
  )

(provide 'init-pbcopy)
