(if macos
    (set-face-attribute 'default nil :font "Intel One Mono")
  (set-face-attribute 'default nil :family "Ubuntu Mono"))
(set-face-attribute 'default nil :height 130)
(set-face-attribute 'default nil :weight 'normal)

(defun mjhoy/change-face (arg)
  "Change the default face to ARG.

When called interactively, presents a list of options to choose
from."
  (interactive
   (list
    (completing-read "Face: "
                     '("Courier" "SF Mono" "Menlo"))))
  (set-face-attribute 'default nil :font arg))

(defun mjhoy/increase-face-height ()
  "Increase the default face height (font size)

Differs from text-scale-adjust by applying to all windows & frames.
"
  (interactive)
  (let* ((current-height (face-attribute 'default :height))
         (new-height (+ current-height 10)))
    (set-face-attribute 'default nil :height new-height)))

(defun mjhoy/decrease-face-height ()
  "Decrease the default face height (font size)

Differs from text-scale-adjust by applying to all windows & frames.
"
  (interactive)
  (let* ((current-height (face-attribute 'default :height))
         (new-height (- current-height 10)))
    (set-face-attribute 'default nil :height new-height)))

(global-set-key (kbd "C-c C-=") 'mjhoy/increase-face-height)
(global-set-key (kbd "C-c C--") 'mjhoy/decrease-face-height)

(setopt text-scale-mode-step 1.14)

(setq-default cursor-type 'box)

;; emoji todo. this doesn't work...
;; (set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend)

(tool-bar-mode 0)

;; Disabling menu-bar-mode on the macports emacs seems to just break
;; its fullscreen-mode.
(unless macport
  (menu-bar-mode 0))

(setopt display-time-24hr-format t)

(if nixos
    (progn
      (scroll-bar-mode 0)
      (display-battery-mode)
      (set-face-attribute 'default nil :family "Noto Mono")
      ))

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
  (setopt mouse-sel-mode t))

;; solves an issue i have with ace-window
(setq-default cursor-in-non-selected-windows 'bar)

;; right option key use as mac normal option (so i can type é easily)
(setopt ns-right-alternate-modifier 'none)

(setopt scroll-conservatively 10000
      scroll-margin 0)

(show-paren-mode t)
(setopt ring-bell-function 'ignore)

;; i don't care about the load average
(setopt display-time-default-load-average nil)

;; use <f13> as a fullscreen key; OS X captures F11
(global-set-key (kbd "<f13>") 'toggle-frame-fullscreen)

(provide 'init-ui)
