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

        # Allow newer vinyl package.
        # composite-base = doJailbreak super.composite-base;
        # composite-aeson = doJailbreak super.composite-aeson;

        # Vinyl 0.8.x
        # vinyl = with self; haskellPackages.mkDerivation {
        #   pname = "vinyl";
        #   version = "0.8.1.1";
        #   src = fetchgit {
        #     url = "https://github.com/VinylRecords/Vinyl.git";
        #     rev = "0917b5bed57428be6609ad030cbb3244b39b52ea";
        #     sha256 = "0jrqa0dzhd3bxv3sp4n1xhs63wn4gd0izy679jasni1wwa7zrbmf";
        #   };
        #   libraryHaskellDepends = [ array base ghc-prim ];
        #   testHaskellDepends = [
        #     base doctest hspec lens microlens should-not-typecheck singletons
        #   ];
        #   benchmarkHaskellDepends = [
        #     base criterion linear microlens mwc-random primitive tagged vector
        #   ];
        #   description = "Extensible Records";
        #   license = stdenv.lib.licenses.mit;
        # };

        # https://github.com/jaspervdj/digestive-functors/issues/151
        # digestive-functors = super.digestive-functors.overrideAttrs (oldAttrs: {
        #   src = (fetchgit {
        #     url = "https://github.com/jonpetterbergman/digestive-functors.git";
        #     rev = "15b9fa07fcec535216522966233bbc8df025118a";
        #     sha256 = "1k67bnniiadnyksgbffib8fx0aa1q7f7ndcwbzyk1jndcgi0bpiv";
        #   }) + "/digestive-functors";
        # });
        # HaXml = doJailbreak super.HaXml;
      };
    };

    nodejsEnv = with pkgs; buildEnv {
      name = "nodeEnv";
      paths = [
        nodejs-8_x
      ];
    };

    aspellEnv = aspellWithDicts(ps: [ ps.en ps.es ]);

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
        myHaskellEnv
        cabal2nix

        diagrams-builder

        # coq
        emacs26Packages.proofgeneral

        # useful tools
        ag
        cloc
        cmake
        ctags
        emacs
        git
        graphviz
        htop
        imagemagick
        jq
        ledger
        lynx
        mu
        nasm
        nix-prefetch-git
        parallel
        pass
        protobuf
        psc-package
        ripgrep
        tmux
        tree
        watch
        wget

        # aspell dictionaries
        aspellEnv
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
      aeson
      aeson-better-errors
      array
      base64-bytestring
      blaze-html
      bower-json
      boxes
      bytestring
      cheapskate
      containers
      data-ordlist
      digestive-functors
      digestive-functors-heist
      digestive-functors-snap
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
      safe
      shakespeare
      singletons
      snap
      snap-loader-static
      snap-templates
      snaplet-postgresql-simple
      sourcemap
      split
      text
      time
      transformers
      turtle
      unordered-containers
      uuid
      vector
      vinyl
      wai-websockets
      websockets
      wreq
    ]);

    # python2Packages = ps: with ps; [
    #   scipy
    #   numpy
    #   scikit-learn
    #   virtualenv
    #   pip
    # ];


    python27Packages = super.python27Packages.override {
      overrides = self: super: {
        numpy = super.numpy.overrideAttrs (oldAttrs: {
          version = "1.11.3";
          src = python2.pkgs.fetchPypi {
            pname = "numpy";
            version = "1.11.3";
            sha256 = "";
          };
        });
        # use a specific (older) version of scipy.
        scipy = super.scipy.overrideAttrs (oldAttrs: {
          verson = "1.0.1";
          src = python2.pkgs.fetchPypi {
            pname = "scipy";
            version = "1.0.1";
            sha256 = "8739c67842ed9a1c34c62d6cca6301d0ade40d50ef14ba292bd331f0d6c940ba";
          };
        });
      };
    };

    myPython2Env = python27Packages.python.withPackages(ps: with ps; [
      numpy
      scipy
      pip
      virtualenv
    ]);

    myPython3Env = python3.withPackages(ps: with ps; [
      matplotlib
    ]);

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
