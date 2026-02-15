final: prev:
prev.metals.overrideAttrs (finalAttrs: prevAttrs: {
  version = "1.6.4";
  deps = prev.stdenv.mkDerivation {
    name = "${prevAttrs.pname}-deps-1.6.4";
    buildCommand = ''
      export COURSIER_CACHE=$(pwd)
      ${prev.coursier}/bin/cs fetch org.scalameta:metals_2.13:1.6.4 \
        -r bintray:scalacenter/releases \
        -r sonatype:snapshots > deps
      mkdir -p $out/share/java
      cp $(< deps) $out/share/java/
    '';
    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = "sha256-MuzyVyTOVWZjs+GPqrztmEilirRjxF9SJIKyxgicbXM=";
  };
  buildInputs = [ finalAttrs.deps ];
})
