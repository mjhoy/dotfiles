(require 'racer)

;; ensure that flycheck is loaded
(require 'init-flycheck)

;; need this for `flycheck-define-checker'
(require 'flycheck)

(add-hook 'rust-mode-hook #'flycheck-rust-setup)

;; to install racer:
;;
;; cargo +nightly install racer
;;
;; rust should exist in ~/src/rust:
;;
;; git clone --depth=1 git@github.com:rust-lang/rust.git ~/src/rust
;; cd ~/src/rusr
;; git checkout <tag (e.g. 1.33.0)>
;; git submodule update --recursive
(let ((src (expand-file-name "~/src/rust/src/")))
  ;; in some instance the env variable must be set too?
  (unless (getenv "RUST_SRC_PATH")
    (setenv "RUST_SRC_PATH" src))
  (setq racer-rust-src-path src))

(defun mjhoy/init-rust-mode ()
  "Set up rust mode"
  (racer-mode)
  (racer-turn-on-eldoc)
  (flycheck-mode 1)
  (setq rust-format-on-save t)
  (set (make-local-variable 'company-backends) '(company-racer))
  (local-set-key (kbd "M-.") #'racer-find-definition))

(add-hook 'rust-mode-hook 'mjhoy/init-rust-mode)

(provide 'init-rust)
