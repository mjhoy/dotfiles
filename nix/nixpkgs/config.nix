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
      jre = jre8;
    };

    sbt = super.sbt.override {
      jre = jre8;
    };

    aspellEnv = aspellWithDicts(ps: [ ps.en ps.es ]);

    # ----------------------
    # Emacs & emacs packages
    # ----------------------

    myEmacs =
      let
        myEmacsBuild = super.emacs;
        myPackages = epkgs: (with epkgs.elpaPackages; [
          ace-window
          cl-lib
          rainbow-mode
          org
        ]) ++ (with epkgs.melpaStablePackages; [
          ag
          apache-mode
          avy
          bm
          cargo
          counsel
          counsel-projectile
          csharp-mode
          dap-mode
          diminish
          dracula-theme
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
          lsp-mode
          lsp-ui
          markdown-mode
          material-theme
          multiple-cursors
          org-mime
          org-tree-slide
          password-store
          php-mode
          posframe
          prettier
          projectile
          protobuf-mode
          racer
          rjsx-mode
          rust-mode
          sbt-mode
          scala-mode
          swift-mode
          terraform-mode
          tide
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
          company-racer
          flycheck-rust
          forge
          gptel
          inf-ruby
          ivy-pass
          lsp-haskell
          lsp-sourcekit
          magit
          nix-mode
          orgit
          ox-reveal
          proof-general
          purescript-mode
          restclient
          ruby-test-mode
        ]);
      in (pkgs.emacsPackagesFor myEmacsBuild).emacsWithPackages myPackages;

    myREnv = super.rWrapper.override {
      packages = with self.rPackages; [
        ggplot2
        lubridate
        plyr
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

        # useful tools
        aspellEnv
        cloc
        cmake
        ctags
        gdb
        git
        graphviz
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

        # scala
        scala
        sbt
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
