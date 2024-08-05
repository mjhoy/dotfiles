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

    linuxOnly = buildEnv {
      name = "linuxOnly";
      paths = [
        # c
        clang

        # other
        bmon
        coreutils
        docker_compose
        dotnet-sdk_5
        mariadb-client
        mdk
        nodejs-14_x
        omnisharp-roslyn
        pinentry
        unzip
        vnstat
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
        zoom-us
      ];
    };

    linuxEnv = buildEnv {
      name = "linuxEnv";
      paths = [
        devEnv
        linuxOnly
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

    scala = super.scala.override {
      jre = jdk17;
    };

    sbt = super.sbt.override {
      jre = jdk17;
    };

    # https://github.com/NixOS/nixpkgs/pull/296012/files
    metals = super.metals.overrideAttrs (final: prev: {
      version = "1.3.5";
      deps = stdenv.mkDerivation {
        name = "${prev.pname}-deps-1.3.5";
        buildCommand = ''
          export COURSIER_CACHE=$(pwd)
          ${super.pkgs.coursier}/bin/cs fetch org.scalameta:metals_2.13:1.3.5 \
            -r bintray:scalacenter/releases \
            -r sonatype:snapshots > deps
          mkdir -p $out/share/java
          cp $(< deps) $out/share/java/
        '';
        outputHashMode = "recursive";
        outputHashAlgo = "sha256";
        outputHash = "sha256-86/zeoOO5kSAwh7uQTV7nGUGQoIux1rlH5eUgvn3kvY=";
      };
      buildInputs = [ final.deps ];
    });

    scala-cli = super.scala-cli.override {
      jre = jdk17;
    };

    aspellEnv = aspellWithDicts(ps: [ ps.en ps.es ]);

    # ----------------------
    # Emacs & emacs packages
    # ----------------------

    myEmacs =
      let
        myEmacsBuild = super.emacs29;
        myPackages = epkgs: (with epkgs; [
          mu4e
        ]) ++ (with epkgs.elpaPackages; [
          ace-window
          cl-lib
          eglot
          modus-themes
          org
          rainbow-mode
        ]) ++ (with epkgs.melpaStablePackages; [
          ag
          apache-mode
          avy
          bm
          cargo
          counsel
          counsel-projectile
          dap-mode
          diminish
          dracula-theme
          edit-indirect
          editorconfig
          elm-mode
          ess
          flycheck
          geiser
          go-mode
          haml-mode
          haskell-mode
          ibuffer-vc
          js2-mode
          jtsx
          markdown-mode
          material-theme
          multiple-cursors
          org-mime
          org-tree-slide
          password-store
          php-mode
          posframe
          projectile
          protobuf-mode
          racer
          rjsx-mode
          rust-mode
          sbt-mode
          swift-mode
          terraform-mode
          web-mode
          winring
          yafolding
          yaml-mode
          yard-mode
          yasnippet
        ]) ++ (with epkgs.nongnuPackages; [
          org-contrib
        ]) ++ (with epkgs.melpaPackages; [
          color-theme-sanityinc-tomorrow
          company
          company-box
          company-prescient
          company-racer
          flycheck-rust
          forge
          gptel
          inf-ruby
          ivy
          ivy-pass
          ivy-prescient
          jq-mode
          ledger-mode
          magit
          nix-mode
          orgit
          ox-reveal
          prettier
          proof-general
          purescript-mode
          restclient
          restclient-jq
          ruby-test-mode
          scala-ts-mode
        ]);
      in (pkgs.emacsPackagesFor myEmacsBuild).emacsWithPackages myPackages;

    myREnv = super.rWrapper.override {
      packages = with self.rPackages; [
        ggplot2
        lubridate
        plyr
      ];
    };

    # https://github.com/NixOS/nixpkgs/blob/9cb99744c338ed8c6b53bcda61b2fb5c77d4563a/pkgs/by-name/em/emacs-lsp-booster/package.nix#L8
    emacs-lsp-booster = rustPlatform.buildRustPackage rec {
      pname = "emacs-lsp-booster";
      version = "0.2.1";

      src = fetchFromGitHub {
        owner = "blahgeek";
        repo = "emacs-lsp-booster";
        rev = "v${version}";
        hash = "sha256-uP/xJfXQtk8oaG5Zk+dw+C2fVFdjpUZTDASFuj1+eYs=";
      };

      cargoHash = "sha256-CvIJ56QrIzQULFeXYQXTpX9PoGx1/DWtgwzfJ+mljEI=";

      nativeCheckInputs = [emacs]; # tests/bytecode_test

      meta = with lib; {
        description = "Emacs LSP performance booster";
        homepage = "https://github.com/blahgeek/emacs-lsp-booster";
        license = licenses.mit;
        maintainers = with maintainers; [icy-thought];
        mainProgram = "emacs-lsp-booster";
      };
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

        # useful tools
        aspellEnv
        cloc
        cmake
        ctags
        git
        graphviz
        hledger
        hledger-web
        htop
        imagemagick
        jq
        ledger
        libxml2
        lynx
        mu
        myEmacs
        myREnv
        nasm
        ngrok
        niv
        nix-prefetch-git
        offlineimap
        parallel
        pass
        protobuf
        ripgrep
        silver-searcher
        tmux
        tree
        watch
        wget
        emacs-lsp-booster

        # scala
        jdk17
        metals
        sbt
        scala
        scala-cli
      ];
    };

    myPython3Env = python3.withPackages (p: with p; [
      virtualenv
      pip
      numpy
      boto3
      matplotlib
    ]);
  };
}
