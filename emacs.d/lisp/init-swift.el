(require 'init-lsp)

(defun mjhoy/setup-swift-mode ()
  "My setup for swift mode."
  (lsp)
  )

(add-hook 'swift-mode-hook #'mjhoy/setup-swift-mode)

(defvar mjhoy/sourcekit-lsp-path
  "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp"
  "The location of the sourcekit-lsp binary")

(eval-after-load 'lsp-mode
  (if (file-exists-p mjhoy/sourcekit-lsp-path)
      (progn
        (require 'lsp-sourcekit)
        (setq lsp-sourcekit-executable mjhoy/sourcekit-lsp-path))))

(provide 'init-swift)
