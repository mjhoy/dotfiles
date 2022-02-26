(require 'init-web-mode)
(require 'init-lsp)

(add-to-list 'auto-mode-alist '("\\.svelte\\'" . web-mode))

(defun mjhoy/init-svelte-mode ()
  "My set up for svelt-mode."

  ;; We're actually in web-mode. So check to make sure we're in a
  ;; svelte file. This seems a bit hacky?
  (let
      ((case-fold-search nil)
       (is-svelte-file (string-match "\\.SVELTE\\'" buffer-file-name)))
    (if is-svelte-file
        (progn
          (lsp)
          )))
  )

(add-hook 'web-mode-hook 'mjhoy/init-svelte-mode)

(provide 'init-svelte)
