(mjhoy/require-package 'yafolding)

;; yafolding
;;
;; C-RET: toggle element
;; C-M-RET: toggle all
(defun mjhoy/init-folding ()
  "Initiaize folding"
  (yafolding-mode 1))

(add-hook 'prog-mode-hook 'mjhoy/init-folding)

(define-key yafolding-mode-map (kbd "C-M-\\") 'yafolding-toggle-all)
(define-key yafolding-mode-map (kbd "C-S-\\") 'yafolding-hide-parent-element)
(define-key yafolding-mode-map (kbd "C-\\") 'yafolding-toggle-element)

(provide 'init-folding)
