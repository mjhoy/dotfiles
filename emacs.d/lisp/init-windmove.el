(windmove-default-keybindings)

;; Make windmove work in org-mode
(eval-after-load 'org
  '(progn
     (add-hook 'org-shiftup-final-hook 'windmove-up)
     (add-hook 'org-shiftleft-final-hook 'windmove-left)
     (add-hook 'org-shiftdown-final-hook 'windmove-down)
     (add-hook 'org-shiftright-final-hook 'windmove-right)))

(provide 'init-windmove)
