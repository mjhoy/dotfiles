(mjhoy/require-package 'diminish)

(require 'diminish)

(eval-after-load "projectile"
  '(diminish 'projectile-mode))
(eval-after-load "autorevert"
  '(diminish 'auto-revert-mode))
(eval-after-load "company"
  '(diminish 'company-mode))
(eval-after-load "yasnippet"
  '(diminish 'yas-minor-mode " ✂"))
(eval-after-load "golden-ratio"
  '(diminish 'golden-ratio-mode " φ"))
(eval-after-load "init-helm"
  '(diminish 'helm-mode))
(eval-after-load "auto-dim-other-buffers"
  '(diminish 'auto-dim-other-buffers-mode))
(diminish 'abbrev-mode)
(diminish 'text-scale-mode)

(provide 'init-diminish)
