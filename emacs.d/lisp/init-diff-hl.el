(require 'init-magit)
(require 'diff-hl)

(global-diff-hl-mode)
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

(provide 'init-diff-hl)
