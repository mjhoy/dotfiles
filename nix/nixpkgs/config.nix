# symlink this file to ~/.nixpkgs/config.nix
{
  allowUnfree = true;

  packageOverrides = super: let self = super.pkgs; in with self; rec {

    hello_world = stdenv.mkDerivation {
      name = "hello_world";
      src = ~/.dotfiles/src/hello_world;
      buildInputs = [ libmikey ];
      installPhase = ''
        mkdir -p $out/bin
        cp hello_world $out/bin/hello_world
      '';
    };

    libmikey = callPackage ~/.dotfiles/nix/pkgs/libmikey {};

    phpEnv56 = buildEnv {
      name = "phpEnv56";
      paths = [
        php56
        (drush.override { php = php56; })
      ];
    };

    linuxOnly = buildEnv {
      name = "linuxOnly";
      paths = [

        # c
        clang

        # node
        nodejs-8_x
        yarn
        purescript

        # other
        mdk
        pinentry
        vnstat
        docker_compose
        bmon
      ];
    };

    # After installing an app, with KDE, need to run:
    #
    # $ kbuildsycoca5
    #
    # to reindex for the apps menu.
    linuxApps = buildEnv {
      name = "linuxApps";
      paths = [
        firefox
        slack
        gimp
      ];
    };

    linuxEnv = buildEnv {
      name = "linuxEnv";
      paths = [
        devEnv
        linuxOnly
      ];
    };

    rEnv = super.rWrapper.override {
      packages = with self.rPackages; [
        ggplot2
        data_table
        plyr
        lubridate
        ascii
        # plotly
      ];
    };

    # TODO: submit bug
    libpsl = super.libpsl.overrideAttrs (oldAttrs: {
      doCheck = false;
    });

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
        # ----------------------------------
        # -- A little note to future self --
        # ----------------------------------
        #
        # Haskell packages will commonly fail with dependency or test
        # failures. Two functions help out here: `doJailbreak` and
        # `dontCheck`. `doJailbreak` essentially says, ignore all
        # dependency version constraints and try to compile
        # anyway. `dontCheck` does not run tests (of course it still
        # fails if compilation fails).
        #
        # If that doesn't work, and the package itself must be fixed,
        # the steps are:
        #
        # 1. Fork the package, download locally.
        # 2. Use cabal2nix --shell to generate a shell.nix file.
        # 3. nix-shell shell.nix. Try to get compiling again using just
        #    `cabal build`.
        # 4. Push up PR with fix.
        # 5. Meanwhile let's override the `src` in the original derivation.
        #    Use `nix-prefetch-git` to get the necessary info, e.g.:
        #
        #    $ nix-prefetch-git https://github.com/mjhoy/psc-package.git 039a42ba780a4f8e342e578177f584d13a6288a7
        #
        #    Now use the output from this in an override:
        #    psc-package = super.psc-package.overrideAttrs (oldAttrs: { src = fetchgit { ... } })

        # https://github.com/NixOS/nixpkgs/pull/57587
        hakyll = haskell.lib.markUnbroken super.hakyll;
      };
    };

    nodejsEnv = with pkgs; buildEnv {
      name = "nodeEnv";
      paths = [
        nodejs-8_x
      ];
    };

    scala = super.scala.override {
      jre = jre8;
    };

    sbt = super.sbt.override {
      jre = jre8;
    };

    aspellEnv = aspellWithDicts(ps: [ ps.en ps.es ]);

    # ----------------
    # Haskell programs
    # ----------------

    phocid = with haskellPackages; haskell.lib.doJailbreak (callPackage (fetchgit {
      url = "https://github.com/mjhoy/phocid";
      rev = "b10747693c3d67115f0ca18cdaa5f048449ea15e";
      sha256 = "1yr0fhm85mbc6nvc6hqgz6s5ib29c7y45ksacami3b24zrq67709";
    }) { });

    # ----------------------
    # Emacs & emacs packages
    # ----------------------

    myEmacs =
      let
        myPackages = epkgs: (with epkgs.elpaPackages; [
          ace-window
          cl-lib
          rainbow-mode
        ]) ++ (with epkgs.melpaStablePackages; [
          ag
          apache-mode
          avy
          bm
          cargo
          counsel
          counsel-projectile
          company
          dap-mode
          diminish
          dracula-theme
          elm-mode
          ess
          flycheck
          geiser
          haml-mode
          ibuffer-vc
          js2-mode
          lsp-mode
          lsp-ui
          markdown-mode
          material-theme
          multiple-cursors
          nix-mode
          org-mime
          org-tree-slide
          password-store
          php-mode
          posframe
          projectile
          proof-general
          # protobuf-mode # https://github.com/nix-community/emacs-overlay/issues/26
          racer
          rjsx-mode
          robe
          rust-mode
          sbt-mode
          scala-mode
          tide
          web-mode
          winring
          yafolding
          yaml-mode
          yard-mode
          yasnippet
        ]) ++ (with epkgs.orgPackages; [
          org-plus-contrib
        ]) ++ (with epkgs.melpaPackages; [
          company-racer
          flycheck-rust
          # TODO: disabled because emacs-sqlite fails to build
          # forge
          inf-ruby
          ivy-pass
          magit
          ox-reveal
          psc-ide
          purescript-mode
          restclient
        ]);
      in (pkgs.emacsPackagesNgGen super.emacs).emacsWithPackages myPackages;


    # ---------------------
    # Developer environment
    # ---------------------
    #
    # To install all at once:
    # $ nix-env -iA nixpkgs.devEnv

    devEnv = buildEnv {
      name = "devEnv";
      paths = [
        libmikey
        # myHaskellEnv
        myPython3Env
        cabal2nix

        # diagrams-builder

        # useful tools
        ag
        awscli
        cloc
        cmake
        ctags
        gdb
        git
        ghcid
        graphviz
        htop
        imagemagick
        jq
        ledger
        libxml2
        lynx
        mu
        myEmacs
        nasm
        nix-prefetch-git
        offlineimap
        parallel
        pass
        # phocid
        protobuf
        psc-package
        ripgrep
        tmux
        tree
        watch
        wget

        # scala
        scala
        sbt

        # aspell dictionaries
        # aspellEnv
      ];
    };

    # haskell environment
    myHaskellEnv = haskellPackages.ghcWithHoogle (p: with p; [
      cabal-install
      hlint
      QuickCheck
      hspec
      hasktags

      # useful libraries...
      # MonadCatchIO-transformers # Dependency problem
      # composite-base
      # composite-aeson
      servant
      servant-server
      Crypto
      # HaXml
      HandsomeSoup
      MonadRandom
      Unixutils
      Cabal_3_0_0_0
      aeson
      aeson-better-errors
      array
      base64-bytestring
      blaze-html
      bower-json
      boxes
      brittany
      bytestring
      cheapskate
      containers
      data-ordlist
      edit-distance
      extra
      filepath
      hakyll
      hscurses
      hsexif
      hspec
      hspec-core
      hxt
      io-streams
      language-javascript
      lens
      monad-logger
      mtl
      optparse-applicative
      pandoc
      parsec
      pattern-arrows
      pipes
      pipes-http
      postgresql-simple
      process
      dhall
      protolude
      readable
      regex-applicative
      regex-base
      regex-compat
      regex-posix
      regex-tdfa
      resource-pool
      safe
      scotty
      shakespeare
      singletons
      # issue building postgres-libpq
      # snaplet-postgresql-simple
      sourcemap
      split
      text
      time
      transformers
      turtle
      unordered-containers
      uuid
      vector
      wai-websockets
      websockets
      wreq
    ]);

    myPython3Env = python3.withPackages (p: with p; [
      virtualenv
      pip
      numpy
      boto3
      matplotlib
    ]);

    # build emacs from source
    emacs-master = pkgs.stdenv.lib.overrideDerivation super.emacs (oldAttrs: {
      name = "emacs-master";
      src = ~/src/emacs;
      buildInputs = oldAttrs.buildInputs ++ [
        pkgs.autoconf pkgs.automake
      ];
      doCheck = false;
    });
  };
}
