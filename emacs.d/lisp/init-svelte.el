(require 'init-web-mode)
(require 'init-eglot)

(add-to-list 'eglot-server-programs '(web-mode . ("svelteserver" "--stdio")))

(add-to-list 'auto-mode-alist '("\\.svelte\\'" . web-mode))

(defvar mjhoy/hacky-svelte-save-point-value 0)

(defun mjhoy/hacky-svelte-save-point ()
  "Save the current cursor position, to restore later.

A big fat hack for getting around an issue with prettier and svelte/web-mode
always setting the cursor back to the top of the file.
"
  (setq-local mjhoy/hacky-svelte-save-point-value (point))
  )

(defun mjhoy/hacky-svelte-restore-point ()
  "Restore the point for the svelte/web-mode hack."
  (goto-char mjhoy/hacky-svelte-save-point-value)
  )

(defun mjhoy/init-svelte-mode ()
  "My set up for svelt-mode."

  ;; We're actually in web-mode. So check to make sure we're in a
  ;; svelte file. This seems a bit hacky?
  (let
      ((case-fold-search nil)
       (is-svelte-file (string-match "\\.SVELTE\\'" buffer-file-name)))
    (if is-svelte-file
        (progn
          ;; For eglot support, see https://github.com/joaotavora/eglot/pull/919/files.
          (eglot-ensure)
          (prettier-mode 1)

          ;; Add the hacky cursor save/restore hooks.
          (add-hook 'before-save-hook 'mjhoy/hacky-svelte-save-point -100 t)
          (add-hook 'after-save-hook 'mjhoy/hacky-svelte-restore-point 100 t)
          )))
  )

(add-hook 'web-mode-hook 'mjhoy/init-svelte-mode)

(provide 'init-svelte)
