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

    # https://github.com/NixOS/nixpkgs/pull/356402/files
    metals = super.metals.overrideAttrs (final: prev: {
      version = "1.4.1";
      deps = stdenv.mkDerivation {
        name = "${prev.pname}-deps-1.4.1";
        buildCommand = ''
          export COURSIER_CACHE=$(pwd)
          ${super.pkgs.coursier}/bin/cs fetch org.scalameta:metals_2.13:1.4.1 \
            -r bintray:scalacenter/releases \
            -r sonatype:snapshots > deps
          mkdir -p $out/share/java
          cp $(< deps) $out/share/java/
        '';
        outputHashMode = "recursive";
        outputHashAlgo = "sha256";
        outputHash = "sha256-CVAPjeTYuv0w57EK/IldJcGz8mTQnyCGAjaUf6La2rU";
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

    emacs30 =
      let
        # https://github.com/NixOS/nixpkgs/blob/b585a1d35ee8f3d76a89d819026f292319fe19c2/pkgs/applications/editors/emacs/make-emacs.nix#L133-L138
        libGccJitLibraryPaths = [
          "${lib.getLib libgccjit}/lib/gcc"
          "${lib.getLib stdenv.cc.libc}/lib"
        ] ++ lib.optionals (stdenv.cc?cc.lib.libgcc) [
          "${lib.getLib stdenv.cc.cc.lib.libgcc}/lib"
        ];
        myEmacsBuild = super.emacs29.overrideAttrs (old : {
          pname = "emacs";
          version = "30.0.91";
          variant = "mainline";
          rev = "30.0.91";
          src = fetchFromGitHub {
             owner = "emacs-mirror";
             repo = "emacs";
             rev = "9a1c76bf7ff49d886cc8e1a3f360d71e62544802";
             sha256 = "sha256-X5J34BUY42JgA1s76eVeGA9WNtesU2c+JyndIHFbONQ=";
          };
          hash = "sha256-X5J34BUY42JgA1s76eVeGA9WNtesU2c+JyndIHFbONQ=";
          preConfigure = "./autogen.sh";
          patches = [
            (substituteAll
              {
                # Taken from https://github.com/NixOS/nixpkgs/blob/b585a1d35ee8f3d76a89d819026f292319fe19c2/pkgs/applications/editors/emacs/native-comp-driver-options-30.patch
                # and https://github.com/NixOS/nixpkgs/blob/b585a1d35ee8f3d76a89d819026f292319fe19c2/pkgs/applications/editors/emacs/make-emacs.nix#L163-L172
                src = ./emacs-native-comp-driver-options-30.patch;
                backendPath = (lib.concatStringsSep " "
                  (builtins.map (x: ''"-B${x}"'') ([
                    # Paths necessary so the JIT compiler finds its libraries:
                    "${lib.getLib libgccjit}/lib"
                  ] ++ libGccJitLibraryPaths ++ [
                    # Executable paths necessary for compilation (ld, as):
                    "${lib.getBin stdenv.cc.cc}/bin"
                    "${lib.getBin stdenv.cc.bintools}/bin"
                    "${lib.getBin stdenv.cc.bintools.bintools}/bin"
                ])));
              })
          ];
        });
      in myEmacsBuild;

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
