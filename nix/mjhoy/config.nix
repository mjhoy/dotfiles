# symlink to ~/.nixpkgs/config.nix

{
  allowUnfree = true;

  # define a derivation i can install/update with
  #
  # $ nix-env -f '<nixpkgs>' -iA myHaskellEnv
  packageOverrides = super: let self = super.pkgs; in with self; rec {

    phocid = haskellPackages.callPackage ~/proj/phocid {};

    pinfold = haskellPackages.callPackage ~/work/pinfold {};

    myHaskellEnv = haskellPackages.ghcWithHoogle (p: with p; [
      cabal-install
      lens
      QuickCheck
      hspec
      snap
    ]);

    # Almost sorta works.
    # Idea: get emacs master (git) building at a repo checkout of ~/src/emacs
    # Todo: figure out how to do the sha bizness w/r/t git.
    emacs-master = pkgs.stdenv.lib.overrideDerivation pkgs.emacs (oldAttrs: {
      name = "emacs-master";
      src = pkgs.fetchgit {
        url = "~/src/emacs";
        rev = "master";
        sha256 = "a00634c20988215a47ec6c00cea85a2eac162597";
      };
      buildInputs = oldAttrs.buildInputs ++ [
        pkgs.autoconf pkgs.automake ];
    });
  };
}
