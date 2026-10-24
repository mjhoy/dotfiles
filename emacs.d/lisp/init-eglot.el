(require 'eglot)

(add-to-list 'eglot-ignored-server-capabilities
             :inlayHintProvider)

;; See https://github.com/joaotavora/eglot/issues/574
(defun mjhoy/eglot-organize-imports () (interactive)
       (eglot-code-actions nil nil "source.organizeImports" t))

(add-to-list 'eglot-server-programs
             '((typescript-ts-mode tsx-ts-mode typescript-mode js-ts-mode js-mode)
               . ("tsc" "--lsp" "--stdio")))

;; Typescript setup -- don't advertise file watching, because tsgo registers a ton of files
;; via recursive globs.
(defconst mjhoy/eglot-typescript-modes
  '(typescript-ts-mode tsx-ts-mode typescript-mode js-ts-mode js-mode))

(defun mjhoy/eglot-disable-typescript-file-watches (original server)
  "Make TypeScript language servers manage their own file watches."
  (let ((capabilities (funcall original server)))
    (when (seq-intersection mjhoy/eglot-typescript-modes
                            (eglot--major-modes server))
      (setf (plist-get (plist-get capabilities :workspace)
                       :didChangeWatchedFiles)
            '(:dynamicRegistration :json-false)))
    capabilities))

(advice-add 'eglot-client-capabilities :around
            #'mjhoy/eglot-disable-typescript-file-watches)

(with-eval-after-load 'eglot
  (progn
    (define-key eglot-mode-map (kbd "C-c C-r") 'eglot-rename)
    (define-key eglot-mode-map (kbd "C-c C-a") 'eglot-code-actions)
    ))

(setq-default eglot-workspace-configuration
              '((haskell (formattingProvider . "fourmolu"))
                (metals (presentationCompilerDiagnostics . :json-false))))

(provide 'init-eglot)
