(mjhoy/require-package 'yafolding)

;; yafolding
;;
;; C-RET: toggle element
;; C-M-RET: toggle all
(defun mjhoy/init-folding ()
  "Initiaize folding"
  (yafolding-mode 1))

(add-hook 'prog-mode-hook 'mjhoy/init-folding)

(provide 'init-folding)
