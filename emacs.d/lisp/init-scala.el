(require 'scala-ts-mode)
(require 'sbt-mode)
(require 'init-eglot)

;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
(setopt sbt:program-options '("-Dsbt.supershell=false"))

(add-to-list 'eglot-server-programs
             '((scala-ts-mode) "env" "JAVA_TOOL_OPTIONS=-Xmx12g" "metals"))

(defun mjhoy/eglot-format-buffer-maybe ()
  "Format via Metals, setting a reasonable timeout."
  (when (and (bound-and-true-p eglot--managed-mode)
             (eglot-current-server)
             (eglot-server-capable :documentFormattingProvider))
    (let ((jsonrpc-default-request-timeout 3))
      (condition-case err
          (eglot-format-buffer)
        (error
         (message "eglot: skipped format on save (%s)"
                  (error-message-string err)))))))

(defun mjhoy/setup-scala-ts-mode ()
  "My setup for scala-ts-mode."
  ;; (eglot-ensure)
  ;; (add-hook 'before-save-hook #'mjhoy/eglot-format-buffer-maybe nil t)
  ;; (add-hook 'before-save-hook #'mjhoy/eglot-organize-imports 5 t)
  )

(add-hook 'scala-ts-mode-hook 'mjhoy/setup-scala-ts-mode)

(provide 'init-scala)
