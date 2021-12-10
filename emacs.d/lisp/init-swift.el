(require 'init-lsp)

(defun mjhoy/setup-swift-mode ()
  "My setup for swift mode."
  (lsp)
  )

(add-hook 'swift-mode-hook #'mjhoy/setup-swift-mode)

(eval-after-load 'lsp-mode
  (progn
    (require 'lsp-sourcekit)
    (setq lsp-sourcekit-executable
          "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp")))

(provide 'init-swift)
