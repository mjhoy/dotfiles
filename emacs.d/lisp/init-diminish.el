(mjhoy/require-package 'diminish)

(require 'diminish)

(eval-after-load "projectile"
  '(diminish 'projectile-mode " §"))
(eval-after-load "company"
  '(diminish 'company-mode))
(eval-after-load "yasnippet"
  '(diminish 'yas-minor-mode " ✂"))
(diminish 'abbrev-mode)

(provide 'init-diminish)
