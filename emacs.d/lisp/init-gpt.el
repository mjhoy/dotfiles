(require 'gptel)

(defun mjhoy/init-gpt ()
  "Initialize gptel api key variable from authinfo"
  (interactive)
  (setq gptel-api-key (funcall (plist-get (car (auth-source-search :host "api.openai.com")) :secret)))
  )

(defun mjhoy/gptel-mode-hook ()
  "My hook function for gptel-mode setup."
  (visual-line-mode)
  (auto-fill-mode 0)
  (setq gptel--num-messages-to-send 8)
  (setq gptel-model "gpt-4")
  )

(add-hook 'gptel-mode-hook 'mjhoy/gptel-mode-hook)

(add-to-list 'gptel-directives '(scala . "You are a large \
language model and a Scala expert, using Scala 2 and not Scala \
3. Provide code and only additional context when necessary."
                                       ))

(provide 'init-gpt)
