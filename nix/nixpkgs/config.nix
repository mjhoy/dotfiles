# symlink this file to ~/.nixpkgs/config.nix
{
  allowUnfree = true;

  # define a environment i can install/update with
  #
  # $ nix-env -iA nixpkgs.all
  packageOverrides = super: let self = super.pkgs; in with self; rec {

    all = buildEnv {
      name = "all";
      paths = [
        phocid
        pinfold
        ybapp

        myHaskellEnv
        cabal2nix

        diagrams-builder
      ];
    };

    phocid  = haskellPackages.callPackage ~/proj/phocid {};
    pinfold = haskellPackages.callPackage ~/work/pinfold {};
    ybapp   = haskellPackages.callPackage ~/work/ybapp {};

    myHaskellEnv = haskellPackages.ghcWithHoogle (p: with p; [
      cabal-install
      ghc-mod
      hlint
      QuickCheck
      hspec

      # useful libraries...
      Unixutils
      array
      blaze-html
      bytestring
      containers
      extra
      hsexif
      lens
      mtl
      optparse-applicative
      process
      regex-applicative
      regex-base
      regex-compat
      regex-posix
      regex-tdfa
      shakespeare
      snap
      vector
      xlsx
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