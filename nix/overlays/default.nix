final: prev: {
  # Temurin builds that drop the emSign roots behind the compromised eMudhra intermediates.
  # Remove once nixpkgs-25.11-darwin ships temurin-bin-17 >= 17.0.21 and temurin-bin-21 >= 21.0.13.
  fixedTemurin =
    pkg: version: url: sha256:
    pkg.overrideAttrs (_: {
      inherit version;
      src = prev.fetchurl { inherit url sha256; };
    });
  jdk17 = final.fixedTemurin prev.temurin-bin-17 "17.0.21"
    "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.21%2B9/OpenJDK17U-jdk_aarch64_mac_hotspot_17.0.21_9.tar.gz"
    "78b08c7f5a0598242d5719c022e19479cb4a3aa45c37c19726a757a469ed1c15";
  jdk21 = final.fixedTemurin prev.temurin-bin-21 "21.0.13"
    "https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.13%2B9/OpenJDK21U-jdk_aarch64_mac_hotspot_21.0.13_9.tar.gz"
    "bf036b35b071bfb2f54f2c0af8ee8d88afa95ee6eb3dce02c0f94cfc2524d04a";
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
