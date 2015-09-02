(mjhoy/require-package 'diminish)

(require 'diminish)

(eval-after-load "projectile"
  '(diminish 'projectile-mode " §"))
(eval-after-load "company"
  '(diminish 'company-mode))
(eval-after-load "yasnippet"
  '(diminish 'yas-minor-mode " ✂"))
(eval-after-load "golden-ratio"
  '(diminish 'golden-ratio-mode " φ"))
(eval-after-load "init-helm"
  '(diminish 'helm-mode " ┏┛"))
(diminish 'abbrev-mode)

(provide 'init-diminish)
