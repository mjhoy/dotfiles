(setq org-ai-use-auth-source nil)
(require 'init-org)
(require 'org-ai)

(defun mjhoy/init-org-ai ()
  "Initialize org-ai api key variable from authinfo"
  (interactive)
  (setq org-ai-openai-api-token
        (funcall (plist-get (car (auth-source-search :host "api.openai.com")) :secret)))
  )

(add-hook 'org-mode-hook #'org-ai-mode)

(provide 'init-org-ai)

