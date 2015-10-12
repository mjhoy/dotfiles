(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c l") 'org-store-link)

(eval-after-load "org"
  '(progn
     ;; the following Shift-arrow commands I want for the `windmove` functions
     (define-key org-mode-map (kbd "<S-right>") nil) ; unbind org-shiftright
     (define-key org-mode-map (kbd "<S-left>")  nil) ; unbind org-shiftleft
     (define-key org-mode-map (kbd "<S-up>")    nil) ; unbind org-shiftup
     (define-key org-mode-map (kbd "<S-down>")  nil) ; unbind org-shiftdown

     ;; C-c ; I want for ace jump
     (define-key org-mode-map (kbd "C-c ;")     nil) ; unbind org-toggle-comment
     ))

(provide 'init-org/bindings)
