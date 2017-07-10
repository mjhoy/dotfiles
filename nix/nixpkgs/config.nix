# symlink this file to ~/.nixpkgs/config.nix
{
  allowUnfree = true;

  packageOverrides = super: let self = super.pkgs; in with self; rec {

    hello_world = stdenv.mkDerivation {
      name = "hello_world";
      src = ~/.dotfiles/src/hello_world;
      installPhase = ''
      mkdir -p $out/bin
      cp hello_world $out/bin/hello_world
      '';
    };

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

    phpEnv = buildEnv {
      name = "phpEnv";
      paths = [
        drush
        php
      ];
    };

    rEnv = super.rWrapper.override {
      packages = with self.rPackages; [
        ggplot2
        data_table
        plyr
        lubridate
        ascii
        plotly
      ];
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
        # heist = dontCheck super.heist;

        # process-extras test suit fails on darwin. See:
        # https://github.com/seereason/process-extras/issues/10
        # process-extras = dontCheck super.process-extras;

        # hakyll's test suite requires `util-linux` for some silly
        # reason.
        # hakyll = dontCheck super.hakyll;

        # Need a version bump on HUnit.
        # snap = self.callPackage ~/src/snap {};

        # Need a version bump on directory.
        snap-loader-dynamic = self.callPackage ~/src/snap-loader-dynamic {};
      };
    };

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

    devEnv = buildEnv {
      name = "devEnv";
      paths = [
        myHaskellEnv
        cabal2nix

        # diagrams-builder

        # coq
        # emacs24Packages.proofgeneral

        # useful tools
        ag
        cmake
        git
        htop
        lynx
        mu
        nasm
        pass
        wget
      ];
    };

    # haskell environment
    myHaskellEnv = haskellPackages.ghcWithHoogle (p: with p; [
      cabal-install
      ghc-mod
      hlint
      QuickCheck
      hspec
      hasktags

      # useful libraries...
      # MonadCatchIO-transformers # Dependency problem
      Crypto
      HaXml
      MonadRandom
      Unixutils
      aeson
      array
      aws
      base64-bytestring
      blaze-html
      bytestring
      containers
      digestive-functors
      digestive-functors-snap
      digestive-functors-heist
      extra
      filepath
      hakyll
      HandsomeSoup
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
      uuid-aeson
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
