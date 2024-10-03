(require 'cape)

(add-to-list 'completion-at-point-functions #'cape-dict)
(add-to-list 'completion-at-point-functions #'cape-emoji)

(provide 'init-cape)
