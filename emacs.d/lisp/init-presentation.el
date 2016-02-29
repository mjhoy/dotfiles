(require 'init-basic)
(require 'init-diminish)
(mjhoy/require-package 'org-tree-slide)


(defun mjhoy/pres ()
  (interactive)
  (mjhoy/switch-theme 'tango-plus)

  ;; theme overrides
  (set-face-attribute 'default nil :height 240)
  (set-face-attribute 'default nil :family "Input Mono")

  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(org-level-1 ((t (:foreground "dark magenta" :weight normal :height 1.4 :family "Input Serif"))))
   '(org-meta-line ((t (:inherit font-lock-comment-face :foreground "White"))))
   '(org-tree-slide-header-overlay-face ((t (:background "white" :foreground "black" :weight normal :height 1.0 :family "Input Sans")))))

  ;; mode line stuff
  (diminish 'auto-fill-function)
  (line-number-mode 0)
  (eval-after-load "org"
    '(diminish 'org-indent-mode))
  )

(provide 'init-presentation)
