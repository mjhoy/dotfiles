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
      vector
      xlsx
    ]);

    myPythonEnv = self.myEnvFun {
      name = "mypython3";
      buildInputs = [
        python34
        python34Packages.matplotlib
      ];
    };

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
