;;; mjhoy-misc.el --- Misc functions for mjhoy that don't fit elsewhere

;;; Commentary:

;; Here lies code I couldn't put anywhere else.
;; Requires 'sensitive-mode (see my site-lisp directory)

;;; Code:

(eval-after-load 'sensitive-mode
  '(defun sudo-find-file (file)
     "Opens FILE with root privileges."
     (interactive "F")
     (set-buffer (find-file (concat "/sudo::" file)))
     (sensitive-mode)))

(defun mjhoy/lookup-apple-dictionary ()
  "Open Apple's dictionary app for the current word."
  (interactive)
  (let* ((myWord (thing-at-point 'symbol))
         (myUrl (concat "dict://" myWord)))
    (browse-url myUrl)))

(defun mjhoy/lookup-dash ()
  "Query Dash.app for the current word."
  (interactive)
  (let* ((myWord (thing-at-point 'symbol))
         (myUrl (concat "dash://" myWord)))
    (browse-url myUrl)))

(provide 'mjhoy-misc)
;;; mjhoy-misc.el ends here
