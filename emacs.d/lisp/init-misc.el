;;; sensitive mode
(require 'sensitive-mode)

;;; opening files with sudo automatically
(defun sudo-find-file (file)
  "Opens FILE with root privileges."
  (interactive "F")
  (set-buffer (find-file (concat "/sudo::" file)))
  (sensitive-mode))

(provide 'init-misc)
