# symlink this file to ~/.nixpkgs/config.nix
{
  allowUnfree = true;

  packageOverrides = super: let self = super.pkgs; in with self; rec {


    # ----------
    # Work stuff
    # ----------
    #
    # The following are packages I'd like to install with `nix' but
    # that are not necessary for my development environment. Basically
    # work projects.
    pinfold = haskellPackages.callPackage ~/work/pinfold {};
    ybapp   = haskellPackages.callPackage ~/work/ybapp {};


    # ---------------------
    # Developer environment
    # ---------------------
    #
    # To install all at once:
    # $ nix-env -iA nixpkgs.devEnv
    devEnv = buildEnv {
      name = "devEnv";
      paths = [
        phocid

        myHaskellEnv
        cabal2nix

        diagrams-builder

        coq
        emacs24Packages.proofgeneral
      ];
    };

    # personal utilities
    phocid  = haskellPackages.callPackage ~/proj/phocid {};

    # haskell environment
    myHaskellEnv = haskellPackages.ghcWithHoogle (p: with p; [
      cabal-install
      ghc-mod
      hlint
      QuickCheck
      hspec

      # useful libraries...
      MonadCatchIO-transformers
      Unixutils
      array
      blaze-html
      bytestring
      containers
      extra
      filepath
      heist
      hsexif
      hspec
      hspec-core
      hspec-snap
      lens
      mtl
      mtl
      optparse-applicative
      postgresql-simple
      process
      readable
      regex-applicative
      regex-base
      regex-compat
      regex-posix
      regex-tdfa
      shakespeare
      snap
      snap-core
      snap-loader-dynamic
      snap-loader-static
      snap-server
      snaplet-postgresql-simple
      snaplet-sass
      text
      time
      transformers
      turtle
      unordered-containers
      vector
      xlsx
    ]);

    myPythonEnv = self.myEnvFun {
      name = "mypython3";
      buildInputs = [
        python3
        python3Packages.matplotlib
      ];
    };

    # build emacs from source
    emacs-master = pkgs.stdenv.lib.overrideDerivation pkgs.emacs (oldAttrs: {
      name = "emacs-master";
      src = ~/src/emacs;
      buildInputs = oldAttrs.buildInputs ++ [
        pkgs.autoconf pkgs.automake
      ];
      doCheck = false;
    });
  };
}
