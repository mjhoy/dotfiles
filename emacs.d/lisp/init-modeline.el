(require 'project)
(require 'subr-x)
(require 'vc)

(declare-function magit-toplevel "magit")

(defun mjhoy/mode-line-vc-branch (text)
  "Extract the branch name from the VC mode-line string TEXT."
  (when (and (stringp text)
             (string-match
              "\\`[[:space:]]*[[:alpha:]]+[-:@!?]\\(.*\\)\\'"
              text))
    (match-string 1 text)))

(defun mjhoy/mode-line-linear-id (text)
  "Extract a Linear issue identifier (ABC-123) from TEXT."
  (when (and (stringp text)
             (string-match
              "\\(?:^\\|[^[:alnum:]]\\)\\([[:alpha:]]\\{2,\\}-[[:digit:]]+\\)"
              text))
    (match-string 1 text)))

(defun mjhoy/mode-line-refresh-vc-state ()
  "Refresh VC state for open files in the current Magit repository."
  (when-let ((root (magit-toplevel)))
    (dolist (buffer (buffer-list))
      (with-current-buffer buffer
        (when (and buffer-file-name
                   (file-in-directory-p buffer-file-name root))
          (vc-refresh-state))))))

(with-eval-after-load 'magit
  (add-hook 'magit-post-refresh-hook #'mjhoy/mode-line-refresh-vc-state))

(defun mjhoy/mode-line-project-and-branch ()
  "Display the current project and a shortened Git branch.

If we detect a linear-like identifier (ABC-123), shorten to that.
Otherwise, truncate it.  Omit the separator unless both values exist."
  (let* ((project (project-current))
         (project-name (when project (project-name project)))
         (branch-name
          (when buffer-file-name
            (or
             (mjhoy/mode-line-vc-branch vc-mode)
             ;; Untracked files have no `vc-mode'; ask the project repository for its branch.
             (when project
               (let* ((root (project-root project))
                      (backend (vc-responsible-backend root t)))
                 (when backend
                   (let ((text (vc-call-backend
                                backend 'mode-line-string root)))
                     (mjhoy/mode-line-vc-branch text))))))))
         (branch
          (when branch-name
            (or (mjhoy/mode-line-linear-id branch-name)
                (truncate-string-to-width branch-name 20 nil nil "…")))))
    (string-join (delq nil (list project-name branch)) ":")))

(setq-default mode-line-format
              '("%e" mode-line-front-space
                mode-line-mule-info
                mode-line-modified
                " "
                mode-line-buffer-identification
                mode-line-format-right-align
                (:eval (mjhoy/mode-line-project-and-branch))
                "  "
                mode-line-position
                " "
                mode-line-modes))

(setq mode-line-right-align-edge 'right-fringe)

(provide 'init-modeline)
