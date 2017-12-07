(mjhoy/require-package 'helm)

(require 'init-projectile)
(mjhoy/require-package 'helm-projectile)
(mjhoy/require-package 'helm-ag)
(mjhoy/require-package 'helm-dash)

(require 'helm)

(helm-mode 1)

(require 'init-mu4e)

(if mjhoy/mu4e-exists-p
    (progn
      ;; note: requires gnu-sed on osx
      ;; $ brew install gnu-sed --with-default-names
      ;; more at https://github.com/emacs-helm/helm-mu
      (add-to-list 'load-path "~/.emacs.d/site-lisp/helm-mu")
      (autoload 'helm-mu "helm-mu" "" t)
      (autoload 'helm-mu-contacts "helm-mu" "" t)))

(global-set-key (kbd "C-c h k") 'helm-show-kill-ring)
(global-set-key (kbd "C-c h r") 'helm-register)
(global-set-key (kbd "C-c h i") 'helm-imenu)
(global-set-key (kbd "C-c h j") 'helm-etags-select)
(global-set-key (kbd "C-c h f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c h o") 'helm-org-in-buffer-headings)
(global-set-key (kbd "C-c h e") 'helm-mu)
(global-set-key (kbd "C-c h d") 'helm-dash-at-point)
(global-set-key (kbd "M-s s") 'helm-projectile-ag)

;; apropos override
(global-set-key (kbd "C-h a") 'helm-apropos)

;; Don't use helm for standard find-file. It's annoying when using
;; TRAMP mode so I keep `C-x f` available as find-file with standard
;; completion.
(add-to-list 'helm-completing-read-handlers-alist '(find-file))

;; old buffer switching
(global-set-key (kbd "C-c h b") 'switch-to-buffer)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-X") 'execute-extended-command)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; make helm usable with tramp
(setq helm-buffer-skip-remote-checking t)

;;; helm projectile integration

(require 'helm-projectile)
(global-set-key (kbd "C-c h p") 'helm-projectile)

(helm-projectile-on)

;; undo the projectile-ag remap
(define-key projectile-mode-map [remap projectile-ag] nil)
(define-key projectile-mode-map (kbd "C-c p s a") #'helm-projectile-ag)

(provide 'init-helm)
