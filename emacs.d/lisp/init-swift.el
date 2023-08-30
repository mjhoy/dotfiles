;; for eglot support, see: https://github.com/joaotavora/eglot/issues/825

(defun mjhoy/setup-swift-mode ()
  "My setup for swift mode."
  )

(add-hook 'swift-mode-hook #'mjhoy/setup-swift-mode)

(defvar mjhoy/sourcekit-lsp-path
  "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp"
  "The location of the sourcekit-lsp binary")

(provide 'init-swift)
