(setq magit-last-seen-setup-instructions "1.4.0")

(mjhoy/require-package 'magit)
(require 'init-org)
(require 'org-magit)

(setq magit-push-always-verify nil)
(setq magit-revert-buffers 'silent)
(setq magit-revision-show-gravatars nil)

(global-set-key (kbd "C-c g") 'magit-status)

;; Hide the "Recent commits" section in status.
;; https://github.com/magit/magit/issues/3230
(magit-add-section-hook 'magit-status-sections-hook
                        'magit-insert-unpushed-to-upstream
                        'magit-insert-unpushed-to-upstream-or-recent
                        'replace)

(magit-define-popup-switch 'magit-log-popup
  ?m "Omit merge commits" "--no-merges")

(magit-define-popup-switch 'magit-fetch-popup
  ?t "Fetch all tags" "--tags")

(defun mjhoy/log-current-commit-to-org-clock ()
  "Get the current repository's HEAD commit, and add it as a link
to the current org clock, if one exists."
  (let* ((repo (magit-toplevel))
         (rev  (magit-git-string "rev-list" "HEAD" "--abbrev-commit" "-n" "1"))
         (link (org-magit-make-link repo "::commit@" rev))
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

(defun mjhoy/git-commit-ci-skip ()
  "If all staged files are markdown, insert [ci skip] into the
commit message."
  (when (and (--all? (string-match-p "\\.md$" it) (magit-staged-files))
             (--any? (string-match-p "\\.md$" it) (magit-staged-files)))
    (insert " [ci skip]")
    (beginning-of-line)))

(add-hook 'git-commit-setup-hook 'mjhoy/git-commit-ci-skip)

(provide 'init-magit)
