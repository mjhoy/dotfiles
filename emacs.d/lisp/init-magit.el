(setopt magit-last-seen-setup-instructions "1.4.0")

(require 'magit)
(require 'init-org)
(require 'forge)

(setopt magit-push-always-verify nil)
(setopt magit-revert-buffers 'silent)
(setopt magit-revision-show-gravatars nil)

;; Don't show closed PRs.
(setopt forge-topic-list-limit '(60 . 0))

;; Only show open topics in status buffers (e.g., no merged PRs).
(setopt forge-status-buffer-default-topic-filters
      (forge--topics-spec :type 'topic :active nil :state 'open :order 'newest))

(global-set-key (kbd "C-c g") 'magit-status)

(defun mjhoy/log-current-commit-to-org-clock ()
  "Get the current repository's HEAD commit, and add it as a link
to the current org clock, if one exists."
  (let* ((repo (magit-toplevel))
         (rev  (magit-git-string "rev-list" "HEAD" "--abbrev-commit" "-n" "1"))
         (link (format "orgit-rev:%s::%s" repo rev))
         (summary (magit-git-string "log" "HEAD" "--format=%B" "-n" "1"))
         (dir  (file-name-nondirectory (directory-file-name repo))))
    (if (org-clock-is-active)
        (save-excursion
          (set-buffer (org-clocking-buffer))
          (goto-char org-clock-marker)
          (end-of-line)
          (newline)
          (insert "- ")
          (insert (format "[[%s][%s.git commit %s]] %s" link dir rev summary))))))

(defun mjhoy/git-commit-hook ()
  (add-hook 'with-editor-post-finish-hook #'mjhoy/log-current-commit-to-org-clock nil t))

(add-hook 'git-commit-mode-hook #'mjhoy/git-commit-hook)

(provide 'init-magit)
