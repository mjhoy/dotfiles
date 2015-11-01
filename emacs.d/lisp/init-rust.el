(mjhoy/require-package 'rust-mode)
(mjhoy/require-package 'racer)
(mjhoy/require-package 'company-racer)

(require 'racer)

;; ensure that flycheck is loaded
(require 'init-flycheck)

;; need this for `flycheck-define-checker'
(require 'flycheck)

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
  (set (make-local-variable 'company-backends) '(company-racer))
  (local-set-key (kbd "M-.") #'racer-find-definition))

(add-hook 'rust-mode-hook 'mjhoy/init-rust-mode)

;; flycheck setup

;; TODO remove when this has hit the flycheck package
;; see: https://github.com/flycheck/flycheck/pull/772
(flycheck-define-checker rust-cargo
  "A Rust syntax checker using Cargo.
This syntax checker needs Cargo with rustc subcommand."
  :command ("cargo" "rustc"
            (eval (if (string= flycheck-rust-crate-type "lib") "--lib" nil))
            "--" "-Z" "no-trans"
            (option-flag "--test" flycheck-rust-check-tests)
            (option-list "-L" flycheck-rust-library-path concat)
            (eval flycheck-rust-args)
            )
  :error-patterns
  ((error line-start (file-name) ":" line ":" column ": "
          (one-or-more digit) ":" (one-or-more digit) " error: "
          (or
           ;; Multiline errors
           (and (message (minimal-match (one-or-more anything)))
                " [" (id "E" (one-or-more digit)) "]")
           (message))
          line-end)
   (warning line-start (file-name) ":" line ":" column ": "
            (one-or-more digit) ":" (one-or-more digit) " warning: "
            (message) line-end)
   (info line-start (file-name) ":" line ":" column ": "
         (one-or-more digit) ":" (one-or-more digit) " " (or "note" "help") ": "
         (message) line-end))
  :modes rust-mode
  :predicate (lambda ()
               (let ((parent-dir (file-name-directory
                                  (directory-file-name
                                   (expand-file-name default-directory)))))
                 ;; Cargo.toml
                 (locate-dominating-file parent-dir "Cargo.toml"))))

(add-to-list 'flycheck-checkers 'rust-cargo)

(defun mjhoy/flycheck-rust-setup-advice ()
  "Advice for the flycheck rust setup.

Basically, hard code `flycheck-rust-crate-type' as \"bin\".

Currently the advised function checks to see whether the current
file is either ~/src/main.rs, or if it lives under ~/src/bin/...
which seems a little odd. Anyway I'm only working on binaries at
the moment."
  (setq-local flycheck-rust-crate-type "bin"))

(eval-after-load 'rust-mode
  '(progn
     (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
     (advice-add 'flycheck-rust-setup :after #'mjhoy/flycheck-rust-setup-advice)
     ))

(provide 'init-rust)
