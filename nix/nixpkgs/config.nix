# symlink this file to ~/.nixpkgs/config.nix
{
  allowUnfree = true;

  packageOverrides = super: let self = super.pkgs; in with self; rec {

    linuxOnly = buildEnv {
      name = "linuxOnly";
      paths = [
        # php development
        drush
        php

        # rust (not available on nix/darwin)
        rustPlatform.rustc
        rustPlatform.cargo

        # c
        clang
        libmjh

        # other
        mdk
      ];
    };

    linuxEnv = buildEnv {
      name = "linuxEnv";
      paths = [
        devEnv
        linuxOnly
      ];
    };

    libmjh = import ~/proj/util/libmjh {
      inherit stdenv;
    };

    # An example nix package that builds GNU's `hello'. See the
    # `example-pkg-hello' directory for how this is set up. Taken from
    # the Nix manual:
    # http://nixos.org/nix/manual/#chap-writing-nix-expressions
    #
    # to build, for instance:
    # $ nix-build "<nixpkgs>" -A example-pkg-hello
    example-pkg-hello = callPackage ~/.dotfiles/nix/pkgs/example-pkg-hello {};


    # ----------------
    # Haskell packages
    # ----------------
    #
    # Overrides to the nix Haskell package set.
    haskellPackages = super.haskellPackages.override {
      overrides = self: super: with haskell.lib; {
        # Heist's test suite is failing in OSX.
        heist = dontCheck super.heist;

        # Hakyll's test suite requires `util-linux` for some silly
        # reason.
        hakyll = dontCheck super.hakyll;
      };
    };


    # ----------
    # Work stuff
    # ----------
    #
    # The following are packages I'd like to install with `nix' but
    # that are not necessary for my development environment. Basically
    # work projects.

    pinfold = haskellPackages.callPackage ~/work/snap_pinfold {};
    ybapp   = haskellPackages.callPackage ~/work/ybapp {};

    chorebot = haskellPackages.callPackage ~/proj/chorebot_hs {};

    nodejsEnv = with pkgs; buildEnv {
      name = "nodeEnv";
      paths = [
        nodejs-0_10
      ];
    };


    # ---------------------
    # Developer environment
    # ---------------------
    #
    # To install all at once:
    # $ nix-env -iA nixpkgs.devEnv

    lslink = haskellPackages.callPackage ~/proj/util/lslink {};

    devEnv = buildEnv {
      name = "devEnv";
      paths = [
        myHaskellEnv
        cabal2nix

        # diagrams-builder

        # coq
        # emacs24Packages.proofgeneral

        nasm
      ];
    };

    # personal utilities
    phocid  = haskellPackages.callPackage ~/proj/phocid {};

    # my website
    mjhoy_com = haskellPackages.callPackage ~/proj/mjhoy.com {};

    # haskell environment
    myHaskellEnv = haskellPackages.ghcWithHoogle (p: with p; [
      cabal-install
      ghc-mod
      hlint
      QuickCheck
      hspec

      # useful libraries...
      # MonadCatchIO-transformers # Dependency problem
      Crypto
      HaXml
      MonadRandom
      Unixutils
      array
      aws
      base64-bytestring
      blaze-html
      bytestring
      containers
      extra
      filepath
      hakyll
      hscurses
      hsexif
      hspec
      hspec-core
      hxt
      io-streams
      lens
      mtl
      optparse-applicative
      pandoc
      parsec
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
      snap-loader-dynamic
      snap-loader-static
      snap-templates
      snaplet-postgresql-simple
      split
      text
      time
      transformers
      turtle
      unordered-containers
      vector
      wreq
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
