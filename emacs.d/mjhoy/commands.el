(defun mjhoy/join-following-line ()
  "Join the following line onto this one."
  (interactive)
  (join-line -1))

(global-set-key (kbd "M-j") 'mjhoy/join-following-line)
