(mjhoy/require-package 'rust-mode)
(mjhoy/require-package 'racer)
(mjhoy/require-package 'company-racer)

(require 'racer)

;; racer should be built in ~/src/racer:
;;
;; git clone https://github.com/phildawes/racer.git ~/src/racer
;; cd ~/src/racer
;; cargo build --release
;;
;; rust should exist in ~/src/rust:
;;
;; git clone --depth=1 git@github.com:rust-lang/rust.git ~/src/rust
(let ((cmd (expand-file-name "~/src/racer/target/release/racer")))
  (setq racer-cmd cmd)
  (setq company-racer-executable cmd))
(setq racer-rust-src-path (expand-file-name "~/src/rust/src/"))

(defun mjhoy/init-rust-mode ()
  "Set up rust mode"
  (racer-mode)
  (racer-turn-on-eldoc)
  (set (make-local-variable 'company-backends) '(company-racer))
  (local-set-key (kbd "M-.") #'racer-find-definition))

(add-hook 'rust-mode-hook 'mjhoy/init-rust-mode)

(provide 'init-rust)
