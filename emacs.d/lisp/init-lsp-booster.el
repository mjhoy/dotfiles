;; Set up for emacs-lsp-booster, which uses a rust wrapper to a) translate
;; json directly into elisp bytescode for faster emacs parsing, and b) not
;; block on IO. More at: https://github.com/blahgeek/emacs-lsp-booster

;; Copied from https://github.com/jdtsmith/eglot-booster/blob/main/eglot-booster.el
;; TODO: Use package
(require 'eglot)
(require 'jsonrpc)

(defcustom eglot-booster-no-remote-boost nil
  "If non-nil, do not boost remote hosts."
  :group 'eglot
  :type 'boolean)

(defun eglot-booster-plain-command (com)
  "Test if command COM is a plain eglot server command."
  (and (consp com)
       (not (integerp (cadr com)))
       (not (memq :autoport com))))

(defvar-local eglot-booster-boosted nil)
(defun eglot-booster--jsonrpc--json-read (orig-func)
  "Read JSON or bytecode, wrapping the ORIG-FUNC JSON reader."
  (if eglot-booster-boosted ; local to process-buffer
      (or (and (= (following-char) ?#)
	       (let ((bytecode (read (current-buffer))))
		 (when (byte-code-function-p bytecode)
		   (funcall bytecode))))
	  (funcall orig-func))
    ;; Not in a boosted process, fallback
    (funcall orig-func)))

(defun eglot-booster--init (server)
  "Register eglot SERVER as boosted if it is."
  (when-let ((server)
	     (proc (jsonrpc--process server))
	     (com (process-command proc))
	     (buf (process-buffer proc)))
    (unless (and (file-remote-p default-directory) eglot-booster-no-remote-boost)
      (if (file-remote-p default-directory) ; com will likely be /bin/sh -i or so
	  (when (seq-find (apply-partially #'string-search "emacs-lsp-booster")
			  (process-get proc 'remote-command)) ; tramp applies this
	    (with-current-buffer buf (setq eglot-booster-boosted t)))
	(when (string-search "emacs-lsp-booster" (car-safe com))
	  (with-current-buffer buf (setq eglot-booster-boosted t)))))))

(defvar eglot-booster--boost
  '("emacs-lsp-booster" "--json-false-value" ":json-false" "--"))

(defun eglot-booster--wrap-contact (args)
  "Wrap contact within ARGS if possible."
  (let ((contact (nth 3 args)))
    (cond
     ((and eglot-booster-no-remote-boost (file-remote-p default-directory)))
     ((functionp contact)
      (setf (nth 3 args)
	    (lambda (&optional interactive)
	      (let ((res (funcall contact interactive)))
		(if (eglot-booster-plain-command res)
		    (append eglot-booster--boost res)
		  res)))))
     ((eglot-booster-plain-command contact)
      (setf (nth 3 args) (append eglot-booster--boost contact))))
    args))

(define-minor-mode eglot-booster-mode
  "Minor mode which boosts plain eglot server programs with emacs-lsp-booster.
The emacs-lsp-booster program must be compiled and available on
variable `exec-path'.  Only local stdin/out-based lsp servers can
be boosted."
  :global t
  :group 'eglot
  (cond
   (eglot-booster-mode
    (unless (executable-find "emacs-lsp-booster")
      (setq eglot-booster-mode nil)
      (user-error "The emacs-lsp-booster program is not installed"))
    (advice-add 'jsonrpc--json-read :around #'eglot-booster--jsonrpc--json-read)
    (advice-add 'eglot--connect :filter-args #'eglot-booster--wrap-contact)
    (add-hook 'eglot-server-initialized-hook #'eglot-booster--init))
   (t
    (advice-remove 'jsonrpc--json-read #'eglot-booster--jsonrpc--json-read)
    (advice-remove 'eglot--connect #'eglot-booster--wrap-contact)
    (remove-hook 'eglot-server-initialized-hook #'eglot-booster--init))))

(provide 'init-lsp-booster)
