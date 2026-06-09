final: prev:
let
  build = prev.emacs30.override { withNativeCompilation = false; };
in (final.emacsPackagesFor build).emacsWithPackages (epkgs: [
  epkgs.mu4e
])
