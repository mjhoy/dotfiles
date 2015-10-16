(set-face-attribute 'default nil :family "Input Mono")

;; nix (/linux) seems to load in fonts much larger
(if nixos
    (set-face-attribute 'default nil :height 115)
  (set-face-attribute 'default nil :height 160))
(set-face-attribute 'default nil :weight 'normal)

(defun mjhoy/proportional ()
  "Use a proportional font"
  (interactive)
  (setq buffer-face-mode-face '(:family "Input Sans" :height 130))
  (setq line-spacing 0)
  (buffer-face-mode))

(defun mjhoy/mono ()
  "Use a monospace font"
  (interactive)
  (setq buffer-face-mode-face '(:family "Input Mono" :height 140))
  (setq line-spacing 0)
  (buffer-face-mode))

;; input is a little tight; increase the line-spacing
(setq-default line-spacing 0.1)
(menu-bar-mode 0)
(when (string-equal system-type "darwin")
  (when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
  (when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
  (when (fboundp 'menu-bar-mode) (menu-bar-mode -1)))

;; right option key use as mac normal option (so i can type é easily)
(setq ns-right-alternate-modifier 'none)

(setq scroll-conservatively 10000)
(show-paren-mode t)
(setq ring-bell-function 'ignore)

;; use <f13> as a fullscreen key; OS X captures F11
(global-set-key (kbd "<f13>") 'toggle-frame-fullscreen)

(provide 'init-ui)
