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

    # https://github.com/NixOS/nixpkgs/pull/380125
    metals = super.metals.overrideAttrs (final: prev: {
      version = "1.5.2";
      deps = stdenv.mkDerivation {
        name = "${prev.pname}-deps-1.5.2";
        buildCommand = ''
          export COURSIER_CACHE=$(pwd)
          ${super.pkgs.coursier}/bin/cs fetch org.scalameta:metals_2.13:1.5.2 \
            -r bintray:scalacenter/releases \
            -r sonatype:snapshots > deps
          mkdir -p $out/share/java
          cp $(< deps) $out/share/java/
        '';
        outputHashMode = "recursive";
        outputHashAlgo = "sha256";
        outputHash = "sha256-2pDZ6jSp8RLGyXmsxaMrtJYMaf8dF5YrG2RZk78Zxzo=";
      };
      buildInputs = [ final.deps ];
    });

    scala-cli = super.scala-cli.override {
      jre = jdk17;
    };

    aspellEnv = aspellWithDicts(ps: [ ps.en ps.es ]);

    myREnv = super.rWrapper.override {
      packages = with self.rPackages; [
        ggplot2
        lubridate
        plyr
      ];
    };

    myEmacs =
      let
        myEmacsBuild = emacs30;
        myPackages = epkgs: (with epkgs; [
          mu4e
        ]);
      in (pkgs.emacsPackagesFor myEmacsBuild).emacsWithPackages myPackages;

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
        fd
        fish
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
        texinfo
        tmux
        tree
        watch
        wget

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
