(require 'init-basic)
(require 'init-diminish)
(mjhoy/require-package 'org-tree-slide)


(defun mjhoy/pres ()
  (interactive)
  (mjhoy/switch-theme 'dichromacy)

  ;; theme overrides
  (set-face-attribute 'default nil :height 200)

  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(org-level-1 ((t (:foreground "dark magenta" :weight normal :height 1.4))))
   '(org-meta-line ((t (:inherit font-lock-comment-face :foreground "White"))))
   '(org-tree-slide-header-overlay-face ((t (:background "white" :foreground "black" :weight normal :height 1.0)))))

  ;; mode line stuff
  (diminish 'auto-fill-function)
  (line-number-mode 0)
  (eval-after-load "org"
    '(diminish 'org-indent-mode))

  (global-set-key (kbd "C-c v") 'mjhoy/presentation-babel)
  )

;; silly hack-y thing: if i'm in org-tree-slide-mode, running
;; org-babel-tangle will tangle only what's in scope and thus not
;; really work, so assuming the current file is called
;; "presentation.org", make an indirect buffer (C-x 4 c) named
;; "presentation.org<2>", turn off org-slide-mode and use this to do
;; the code tangling.
(defun mjhoy/presentation-babel ()
  (interactive)
  (switch-to-buffer "presentation.org<2>")
  (org-babel-tangle)
  (switch-to-buffer "presentation.org"))

(provide 'init-presentation)
