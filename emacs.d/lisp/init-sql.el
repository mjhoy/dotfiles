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

(provide 'init-sql)
