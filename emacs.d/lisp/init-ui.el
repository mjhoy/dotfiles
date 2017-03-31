(if macos
    (set-face-attribute 'default nil :font "SF Mono")
  (set-face-attribute 'default nil :family "Ubuntu Mono"))
(set-face-attribute 'default nil :height 150)
(set-face-attribute 'default nil :weight 'normal)

(setq text-scale-mode-step 1.14)

(setq-default cursor-type 'bar)

;; emoji todo. this doesn't work...
;; (set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend)

(tool-bar-mode 0)

(setq display-time-24hr-format t)

(if nixos
    (progn
      (menu-bar-mode 0)
      (scroll-bar-mode 0)
      (display-battery-mode)
      (display-time-mode 1)))

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
