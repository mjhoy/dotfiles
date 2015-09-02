(require 'flyspell)

(setq flyspell-issue-message-flag nil)

;; assumes aspell and english+spanish+british are installed.
;; on mac/homebrew:
;; $ brew install aspell --with-lang-en --with-lang-es --with-lang-uk
(let ((langs '("american" "espanol" "british")))
  (setq my-lang-ring (make-ring (length langs)))
  (dolist (elem langs) (ring-insert my-lang-ring elem)))

(defun mjhoy/cycle-ispell-languages ()
  (interactive)
  (let ((lang (ring-ref my-lang-ring -1)))
    (ring-insert my-lang-ring lang)
    (ispell-change-dictionary lang)))

(global-set-key (kbd "<f6>") 'mjhoy/cycle-ispell-languages)

(provide 'init-flyspell)
