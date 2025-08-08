(require 'diminish)

(eval-after-load "projectile"
  '(diminish 'projectile-mode))
(eval-after-load "autorevert"
  '(diminish 'auto-revert-mode))
(eval-after-load "yasnippet"
  '(diminish 'yas-minor-mode))
(eval-after-load "golden-ratio"
  '(diminish 'golden-ratio-mode " φ"))
(eval-after-load "cargo"
  '(diminish 'cargo-minor-mode))
(eval-after-load "eldoc"
  '(diminish 'eldoc-mode))
(eval-after-load "init-ivy"
  '(diminish 'ivy-mode))
(eval-after-load "init-which-key"
  '(diminish 'which-key-mode))
(eval-after-load "auto-dim-other-buffers"
  '(diminish 'auto-dim-other-buffers-mode))
(diminish 'abbrev-mode)
(diminish 'text-scale-mode)
(eval-after-load "monet"
  '(diminish 'monet-mode))

(provide 'init-diminish)
