(if (file-exists-p "~/.nix-profile/share/emacs/site-lisp/ProofGeneral")
    (load "~/.nix-profile/share/emacs/site-lisp/ProofGeneral/generic/proof-site.el"))

;; bug, see: http://proofgeneral.inf.ed.ac.uk/trac/ticket/496
(add-hook 'proof-ready-for-assistant-hook (lambda () (show-paren-mode 0)))

(provide 'init-coq)
