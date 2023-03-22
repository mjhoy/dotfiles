(require 'gptel)

(defun mjhoy/init-gpt ()
  "Initialize gptel api key variable from authinfo"
  (interactive)
  (setq gptel-api-key (funcall (plist-get (car (auth-source-search :host "api.openai.com")) :secret)))
  )

(defun mjhoy/gptel-mode-hook ()
  "My hook function for gptel-mode setup."
  (visual-line-mode)
  )

(add-hook 'gptel-mode-hook 'mjhoy/gptel-mode-hook)

(provide 'init-gpt)
