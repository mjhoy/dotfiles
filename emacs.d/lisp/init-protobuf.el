(require 'protobuf-mode)

(defun mjhoy/setup-protobuf-mode ()
  "My setup for protobuf-mode."

  (setopt c-basic-offset 2)
  )

(add-hook 'protobuf-mode-hook #'mjhoy/setup-protobuf-mode)

(provide 'init-protobuf)
