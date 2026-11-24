{ pkgs, emacs }:

(pkgs.emacsPackagesFor emacs).emacsWithPackages (epkgs: [
  epkgs.mu4e
  (epkgs.treesit-grammars.with-grammars (grammars: [
    grammars.tree-sitter-javascript
    grammars.tree-sitter-jsdoc
    grammars.tree-sitter-rust
    grammars.tree-sitter-scala
    grammars.tree-sitter-tsx
    grammars.tree-sitter-typescript
    grammars.tree-sitter-yaml
  ]))
])
