(require 'eglot)

(add-to-list 'eglot-ignored-server-capabilities
             :inlayHintProvider)

(provide 'init-eglot)
