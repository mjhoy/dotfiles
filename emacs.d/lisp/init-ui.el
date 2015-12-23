(if nixos
    (set-face-attribute 'default nil :family "Hack")
  (set-face-attribute 'default nil :family "Menlo"))

;; nix (/linux) seems to load in fonts much larger
(if nixos
    (set-face-attribute 'default nil :height 115)
  (set-face-attribute 'default nil :height 140))
(set-face-attribute 'default nil :weight 'normal)

(setq text-scale-mode-step 1.14)

(setq-default cursor-type 'bar)

;; inhibit tool bar
(tool-bar-mode 0)

;; show 24h clock in the mode line
(setq display-time-24hr-format t)
(display-time-mode 1)

;; input is a little tight; increase the line-spacing
(setq-default line-spacing 0.1)

(if (string-equal system-type "darwin")
    (progn
      (if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
      (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))))

;; solves an issue i have with ace-window
(setq-default cursor-in-non-selected-windows 'bar)

;; right option key use as mac normal option (so i can type é easily)
(setq ns-right-alternate-modifier 'none)

(setq scroll-conservatively 10000)
(show-paren-mode t)
(setq ring-bell-function 'ignore)

;; use <f13> as a fullscreen key; OS X captures F11
(global-set-key (kbd "<f13>") 'toggle-frame-fullscreen)

(provide 'init-ui)
