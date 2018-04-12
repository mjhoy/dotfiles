# symlink this file to ~/.nixpkgs/config.nix
{
  allowUnfree = true;

  packageOverrides = super: let self = super.pkgs; in with self; rec {

    # Purescript is a top-level Nix package (e.g., nix-env -iA
    # nixpkgs.purescript), but it is also a Haskell library. We can
    # plow ahead through dependency problems with `doJailbreak` here.
    purescript = super.haskell.lib.doJailbreak super.purescript;

    psc-package =
      super.haskell.lib.doJailbreak (super.psc-package.overrideAttrs (oldAttrs: {
        src = fetchgit {
          url = "https://github.com/mjhoy/psc-package.git";
          rev = "039a42ba780a4f8e342e578177f584d13a6288a7";
          sha256 = "0kyxwzn33qdlj17dd87076bymvg0nzzi7ahnyxkfba1cgfdjxzpz";
        };
      }));

    # mu version 1.0, PR here:
    # https://github.com/NixOS/nixpkgs/pull/34633
    mu = super.mu.overrideAttrs (oldAttrs: rec {
      name = "mu-${version}";
      version = "1.0";
      src = fetchgit {
        url    = "https://github.com/djcg/mu.git";
        rev    = "v${version}";
        sha256 = "0y6azhcmqdx46a9gi7mn8v8p0mhfx2anjm5rj7i69kbr6j8imlbc";
      };
      postPatch = ''
        sed -i -e '/test-utils/d' lib/parser/Makefile.am
      '';
      nativeBuildInputs = [ pkgconfig autoreconfHook pmccabe ];
      enableParallelBuilding = true;
    });

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

        # Heist's test suite is failing on pandoc2.
        # See: https://github.com/snapframework/heist/pull/111
        heist = dontCheck super.heist;

        # Not sure why this is failing. Keeps saying missing directory
        # == 1.2.*, but I don't know where that comes from.
        #
        # snap-loader-dynamic = doJailbreak (super.snap-loader-dynamic.overrideAttrs (oldAttrs: {
        #   src = fetchgit {
        #     url = "https://github.com/snapframework/snap-loader-dynamic";
        #     rev = "2bbf96c4cad2b0c4e60e999607f68c1f6ddfdd92";
        #     sha256 = "0vp8b020wb2aj16nbbwnszxwfrhl1c1gz373gv4pbi5zx0m93fzf";
        #   };
        # }));

        # Missing deps: base >=4 && <4.10
        # Waiting on: https://github.com/mightybyte/snaplet-postgresql-simple/pull/46
        snaplet-postgresql-simple = doJailbreak super.snaplet-postgresql-simple;
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
        libmikey
        myHaskellEnv
        cabal2nix

        # diagrams-builder

        # coq
        # emacs24Packages.proofgeneral

        # useful tools
        ag
        cloc
        cmake
        emacs
        git
        htop
        lynx
        mu
        nasm
        parallel
        pass
        psc-package
        ripgrep
        tmux
        wget
        nix-prefetch-git
        watch
        ledger
        imagemagick

        # aspell dictionaries
        aspell
        aspellDicts.en
        aspellDicts.es
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
      Crypto
      HaXml
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
      protolude
      readable
      regex-applicative
      regex-base
      regex-compat
      regex-posix
      regex-tdfa
      scotty
      shakespeare
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
      wai-websockets
      websockets
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
