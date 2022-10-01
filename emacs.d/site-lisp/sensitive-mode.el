;; see: http://anirudhsasikumar.net/blog/2005.01.21.html
(define-minor-mode sensitive-mode
  "Disable backup creation and auto saving."
  :lighter " Sensitive"
  (if (symbol-value sensitive-mode)
      (progn
        (set (make-local-variable 'backup-inhibited) t)
        (if auto-save-default
            (auto-save-mode -1)))
    (kill-local-variable 'backup-inhibited)
    (if auto-save-default
        (auto-save-mode 1))))

(provide 'sensitive-mode)
