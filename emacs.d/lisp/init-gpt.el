(require 'gptel)

(defun mjhoy/gptel-mode-hook ()
  "My hook function for gptel-mode setup."
  (visual-line-mode)
  (auto-fill-mode 0)
  (setopt gptel--num-messages-to-send 8)
  )

(add-hook 'gptel-mode-hook 'mjhoy/gptel-mode-hook)

(add-to-list 'gptel-directives '(scala . "You are a large \
language model and a Scala expert, using Scala 2 and not Scala \
3. Provide code and only additional context when necessary."
                                       ))

(setopt gptel-model 'gpt-4o-mini)

(defvar mjhoy/gptel-models
  '((gpt-4o-mini . nil)                 ; nil uses default backend
    (gemma3:27b . ollama)
    (deepseek-r1:32b . ollama))
  "List of models and their backends for gptel to use.

For ollama models, you can install via `ollama run <model>`.
")

(defun mjhoy/switch-gptel-model ()
  "Ask which model to use with gptel."
  (interactive)
  (let* ((choice (completing-read "Select model: "
                                  (mapcar #'car mjhoy/gptel-models)))
         (model (intern choice))
         (backend (alist-get model mjhoy/gptel-models)))
    (setopt gptel-model model)
    (if (eq backend 'ollama)
        (setopt gptel-backend
                   (gptel-make-ollama "Ollama"
                     :host "localhost:11434"
                     :stream t
                     :models (list model))))))

(provide 'init-gpt)
