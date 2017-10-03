(require 'dired)

(mjhoy/require-package 'dired-details)
(require 'dired-details)
(setq-default dired-details-hidden-string "--- ")
(dired-details-install)

(setq dired-listing-switches "-laGh")

(defun dired-get-size ()
  "Get (recursive) size total of all marked entries"
  (interactive)
  (let ((files (dired-get-marked-files)))
    (with-temp-buffer
      (apply 'call-process "/usr/bin/du" nil t nil "-sch" files)
      (message
       "Size of all marked files: %s"
       (progn
         (re-search-backward "^\s?\\([0-9.,]+[A-Za-z]+\\).*total$")
         (match-string 1))))))

(defun mjhoy/dired-create-file (file)
  "Create a file called FILE.
If FILE already exists, signal an error."
  (interactive
   (list (read-file-name "Create file: " (dired-current-directory))))
  (let* ((expanded (expand-file-name file))
         (command (format "%s \"%s\"" "touch" expanded)))
    (if (file-exists-p expanded)
        (error "Cannot create file %s: file exists" expanded)
      (call-process-shell-command command)
      (dired-add-file expanded))))

(define-key dired-mode-map (kbd "z") 'dired-get-size)
(define-key dired-mode-map (kbd "C-+") 'mjhoy/dired-create-file)

(provide 'init-dired)
