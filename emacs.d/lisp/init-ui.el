(if macos
    (set-face-attribute 'default nil :font "SF Mono")
  (set-face-attribute 'default nil :family "Ubuntu Mono"))
(set-face-attribute 'default nil :height 130)
(set-face-attribute 'default nil :weight 'normal)

(setq text-scale-mode-step 1.14)

(setq-default cursor-type 'box)

;; emoji todo. this doesn't work...
;; (set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend)

(tool-bar-mode 0)
(menu-bar-mode 0)

(setq display-time-24hr-format t)

(if nixos
    (progn
      (scroll-bar-mode 0)
      (display-battery-mode)))

(if (string-equal system-type "darwin")
    (progn
      (if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
      (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))))

;; enable mouse support in a terminal
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] (lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] (lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t))

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
