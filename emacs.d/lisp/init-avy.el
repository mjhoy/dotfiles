(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

(global-set-key (kbd "C-x p") 'ace-window)

(global-set-key (kbd "C-c ;") 'avy-goto-char-2)
(global-set-key (kbd "C-c '") 'avy-goto-line)
(global-set-key (kbd "C-c C-j") 'avy-resume)

(eval-after-load "isearch"
  '(define-key isearch-mode-map (kbd "C-c ;") 'avy-isearch))

(provide 'init-avy)
