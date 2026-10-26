final: prev: {
  # Zulu builds that drop the emSign roots behind the compromised eMudhra intermediates.
  # TODO: remove once nixpkgs ships zulu17 >= 17.0.21 and zulu21 >= 21.0.13.
  fixedZulu =
    pkg: major: version: url: hash:
    pkg.overrideAttrs (finalAttrs: old: {
      inherit version;
      src = prev.fetchurl {
        inherit url hash;
        curlOpts = "-H Referer:https://www.azul.com/downloads/zulu/";
      };
      # Note: Newer Zulu tarballs unpack to Contents/ at the top level and nixpkgs expects zulu-NN.jdk/Contents.
      installPhase = ''
        if [ -d Contents ] && [ ! -d zulu-${major}.jdk ]; then
          mkdir zulu-${major}.jdk
          mv Contents zulu-${major}.jdk/
        fi
      '' + old.installPhase;
      # passthru.home/bundle in nixpkgs point at the pre-override derivation
      passthru = old.passthru // {
        home = finalAttrs.finalPackage;
        bundle = "${finalAttrs.finalPackage}/Library/Java/JavaVirtualMachines/zulu-${major}.jdk";
      };
    });
  zulu17 = final.fixedZulu prev.zulu17 "17" "17.0.21"
    "https://cdn.azul.com/zulu/bin/zulu17.70.111-ca-jdk17.0.21-macosx_aarch64.tar.gz"
    "sha256-jlFJXTT01aWwI+LlJcZa+z+xOeQFB/y8Pc+UnKE85VA=";
  zulu21 = final.fixedZulu prev.zulu21 "21" "21.0.13"
    "https://cdn.azul.com/zulu/bin/zulu21.54.107-ca-jdk21.0.13-macosx_aarch64.tar.gz"
    "sha256-doL8u8OhZDUtNsCclrKqkYQci7r9uamn9fBNttKQpiQ=";
  jdk17 = final.zulu17;
  jdk21 = final.zulu21;
  scala = prev.scala.override { jre = final.jdk17; };
  sbt = prev.sbt.override { jre = final.jdk17; };
  scala-cli = prev.scala-cli.override { jre = final.jdk17; };
  metals = import ./metals.nix final prev;
  scalafmt = import ./scalafmt.nix final prev;
  myEmacs = import ./emacs.nix {
    pkgs = final;
    emacs = prev.emacs30.override { withNativeCompilation = false; };
  };
  aspellEnv = final.aspellWithDicts (ps: [ ps.en ps.es ]);
  myREnv = prev.rWrapper.override {
    packages = with final.rPackages; [ ggplot2 lubridate plyr ];
  };
  libmikey = final.callPackage ../pkgs/libmikey {};
  myCacert = prev.cacert.override {
    blacklist = [
      "Comodo AAA Services root"
      "emSign ECC Root CA - G3"
      "emSign Root CA - C1"
      "emSign ECC Root CA - C3"
    ];
  };
}
