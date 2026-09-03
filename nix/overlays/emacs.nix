{ pkgs, emacs }:

(pkgs.emacsPackagesFor emacs).emacsWithPackages (epkgs: [
  epkgs.mu4e
])
