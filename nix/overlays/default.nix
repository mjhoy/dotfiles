final: prev: {
  scala = prev.scala.override { jre = final.jdk17; };
  sbt = prev.sbt.override { jre = final.jdk17; };
  scala-cli = prev.scala-cli.override { jre = final.jdk17; };
  metals = import ./metals.nix final prev;
  myEmacs = import ./emacs.nix final prev;
  aspellEnv = final.aspellWithDicts (ps: [ ps.en ps.es ]);
  myREnv = prev.rWrapper.override {
    packages = with final.rPackages; [ ggplot2 lubridate plyr ];
  };
  libmikey = final.callPackage ../pkgs/libmikey {};
}
