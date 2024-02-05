;; TODO: I haven't yet figured out how to manage treesitter grammars
;; with nix yet, so for now I'm just compiling manually. This is
;; actually pretty easy with the "casouri/tree-sitter-module" script
;; linked here:
;; https://git.savannah.gnu.org/cgit/emacs.git/tree/admin/notes/tree-sitter/starter-guide?h=feature/tree-sitter
;;
;; I cloned the repo in ~/src and ran the `batch.sh` script.
(if (file-directory-p (expand-file-name "~/src/tree-sitter-module/dist"))
    (add-to-list 'treesit-extra-load-path (expand-file-name "~/src/tree-sitter-module/dist")))

(provide 'init-treesitter)
