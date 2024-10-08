(require 'gptel)

(defun mjhoy/gptel-mode-hook ()
  "My hook function for gptel-mode setup."
  (visual-line-mode)
  (auto-fill-mode 0)
  (setq gptel--num-messages-to-send 8)
  )

(add-hook 'gptel-mode-hook 'mjhoy/gptel-mode-hook)

(add-to-list 'gptel-directives '(scala . "You are a large \
language model and a Scala expert, using Scala 2 and not Scala \
3. Provide code and only additional context when necessary."
                                       ))

(setq gptel-model "gpt-4o-mini")

(global-set-key (kbd "C-c k") #'gptel-send)

(provide 'init-gpt)
