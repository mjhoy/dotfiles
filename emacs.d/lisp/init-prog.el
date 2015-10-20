;; General prog-mode stuff

(defun mjhoy/prog-mode-hook ()
  "My hook function for prog mode setup."
  (setq show-trailing-whitespace t))

(add-hook 'prog-mode-hook 'mjhoy/prog-mode-hook)

(provide 'init-prog)
