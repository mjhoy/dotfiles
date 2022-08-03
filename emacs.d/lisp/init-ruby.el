(add-to-list 'auto-mode-alist '("Rakefile\\'"   . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'"    . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))

(require 'ruby-test-mode)

(require 'lsp-solargraph)

;; disable -b (no full backtraces, which are annoying.)
(setq ruby-test-rspec-options '("-b"))

(eval-after-load 'ruby-test-mode
  '(progn
     (define-key ruby-test-mode-map (kbd "C-c M-t") 'ruby-test-run)
     (define-key ruby-test-mode-map (kbd "C-c C-t") 'ruby-test-run-at-point)))

(defun mjhoy/setup-ruby-mode ()
  "My setup for ruby-mode."
  (yard-mode)
  (lsp)
  )

(defun mjhoy/setup-inf-ruby-mode ()
  "My setup for inf-ruby-mode."
  (company-mode -1))

(add-hook 'ruby-mode-hook 'mjhoy/setup-ruby-mode)
(add-hook 'inf-ruby-mode-hook 'mjhoy/setup-inf-ruby-mode)
(setq ruby-insert-encoding-magic-comment nil)

(defun mjhoy/rails-compile-assets (branch)
  "Compile rails assets for the root magit directory.

Uses magit for all git commands. The nice thing about this is
that it cleans up my buffer states for me.

Assumes there is a branch `deploy` in the repository that is
tracking commits for deployment: in other words, running `rake
assets:precompile`.

This will merge `deploy` with the current branch, precompile the
assets, commit the changes (if any), push `deploy` to origin, and
checkout the old branch.
"
  (interactive (list
                (read-string "Branch to compile assets for (deploy): "
                             nil nil "deploy")))
  (let ((current-branch (magit-get-current-branch))
        (default-directory (magit-toplevel)))
    (magit-checkout branch)
    (magit-run-git "merge" current-branch "--no-edit")
    (message "Running assets:precompile")
    (shell-command "RAILS_ENV=production bundle exec rake assets:precompile")
    (if (or (magit-anything-modified-p)
            (magit-anything-unstaged-p)
            (magit-git-string "ls-files" "--other" "--directory" "--no-empty-directory" "--exclude-standard"))
        (progn
          (magit-run-git "add" "--all" "public/")
          (magit-run-git "commit" "-m" "precompile assets for deploy")))
    (magit-run-git "push" "origin" branch)
    (magit-checkout current-branch)
    (message "Compile assets finished")))

(provide 'init-ruby)
