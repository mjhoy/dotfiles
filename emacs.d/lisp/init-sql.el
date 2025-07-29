(defun mjhoy/mysql-scratch ()
  "Create a new scratch buffer set up for mysql"
  (interactive)
  (let ((mysql-buffer (get-buffer-create "*mysql-scratch*")))
    (with-current-buffer mysql-buffer
      (sql-mode)
      (sql-highlight-mysql-keywords)
      (sql-set-sqli-buffer))
    (split-window-sensibly)
    (switch-to-buffer mysql-buffer)))

(defun mjhoy/postgres-scratch ()
  "Create a new scratch buffer set up for postgres"
  (interactive)
  (let ((postgres-buffer (get-buffer-create "*postgres-scratch*")))
    (with-current-buffer postgres-buffer
      (sql-mode)
      (sql-highlight-postgres-keywords)
      (sql-set-sqli-buffer))
    (split-window-sensibly)
    (switch-to-buffer postgres-buffer)))

;; use the Postgres mac app if it exists.
(unless (locate-file "psql" exec-path)
  (let ((mac-psql "/Applications/Postgres.app/Contents/Versions/9.6/bin/psql"))
    (if (file-exists-p mac-psql)
        (setopt sql-postgres-program mac-psql))))

(provide 'init-sql)
