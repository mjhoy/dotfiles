(mjhoy/require-package 'helm)

(require 'init-projectile)
(mjhoy/require-package 'helm-projectile)
(mjhoy/require-package 'helm-ag)

;; I want to use helm for as much as possible, but one issue is that
;; it crashes on OSX for large matching lists, see:
;; https://github.com/bbatsov/projectile/issues/600
;;
;; Until then I'll keep ido around as well.

(require 'helm)

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
(global-set-key (kbd "C-c h i") 'helm-imenu)
(global-set-key (kbd "C-c h j") 'helm-etags-select)
(global-set-key (kbd "C-c h f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-c h o") 'helm-org-in-buffer-headings)
(global-set-key (kbd "C-c h e") 'helm-mu)

;; old buffer switching
(global-set-key (kbd "C-c h b") 'switch-to-buffer)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-X") 'execute-extended-command)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; helm projectile integration

(require 'helm-projectile)
(global-set-key (kbd "C-c h p") 'helm-projectile)

(helm-projectile-on)

(defun mjhoy/helm-projectile-ag ()
  "Helm version of projectile-ag that uses helm-ag instead of helm-do-ag"
  (interactive)
  (unless (executable-find "ag")
    (error "ag not available"))
  (if (require 'helm-ag nil  'noerror)
      (if (projectile-project-p)
          (let* ((helm-ag-insert-at-point 'symbol)
                 (grep-find-ignored-files (-union projectile-globally-ignored-files grep-find-ignored-files))
                 (grep-find-ignored-directories (-union projectile-globally-ignored-directories grep-find-ignored-directories))
                 (ignored (mapconcat (lambda (i)
                                       (concat "--ignore " i))
                                     (append grep-find-ignored-files grep-find-ignored-directories)
                                     " "))
                 (helm-ag-base-command (concat helm-ag-base-command " " ignored)))
            (helm-ag (projectile-project-root)))
        (error "You're not in a project"))
    (error "helm-ag not available")))

(define-key projectile-command-map (kbd "s s") 'mjhoy/helm-projectile-ag)

(provide 'init-helm)
