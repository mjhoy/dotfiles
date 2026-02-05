(require 'dumb-jump)

(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)

(provide 'init-dumb-jump)
