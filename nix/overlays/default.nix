final: prev: {
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
    blacklist = [ "Comodo AAA Services root" ]
      ++ prev.lib.optionals (prev.lib.versionOlder prev.cacert.version "3.131.1") [
        "emSign ECC Root CA - G3"
        "emSign Root CA - C1"
        "emSign ECC Root CA - C3"
      ];
  };
}
