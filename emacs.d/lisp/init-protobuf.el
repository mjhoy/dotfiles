(require 'protobuf-mode)

(defun mjhoy/setup-protobuf-mode ()
  "My setup for protobuf-mode."

  (setopt c-basic-offset 2)
  (add-hook 'before-save-hook #'mjhoy/buf-before-save nil 'local))

(defun mjhoy/buf-before-save ()
  "Run buf format on the current protobuf file before saving."
  ;; TODO: actually make this work (i think there's an issue when editing a file vs buffer)
  ;; (let ((file (buffer-file-name)))
  ;;   (when file
  ;;     (let
  ;;         ((old-point (point))
  ;;          (output (shell-command-to-string (concat "buf format " file))))
  ;;       ;; Replace the content of the current buffer with the output
  ;;       (erase-buffer)
  ;;       (insert output)
  ;;       ;; Optionally ensure the file is marked as modified if needed
  ;;       (set-visited-file-modtime nil)
  ;;       (goto-char old-point)
  ;;       ))))
  )


(add-hook 'protobuf-mode-hook #'mjhoy/setup-protobuf-mode)

(provide 'init-protobuf)
