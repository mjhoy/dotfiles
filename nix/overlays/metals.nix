final: prev:
prev.metals.overrideAttrs (finalAttrs: prevAttrs: {
  version = "2.0.0-M7";
  deps = prev.stdenv.mkDerivation {
    name = "${prevAttrs.pname}-deps-2.0.0-M7";
    buildCommand = ''
      export COURSIER_CACHE=$(pwd)
      ${prev.coursier}/bin/cs fetch org.scalameta:metals_2.13:2.0.0-M7 \
        -r bintray:scalacenter/releases \
        -r sonatype:snapshots > deps
      mkdir -p $out/share/java
      cp $(< deps) $out/share/java/
    '';
    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = "sha256-u6FUGO4RWlx2yUKEi91FK5Z/MxMsYOZZYEANma1gV9E=";
  };
  buildInputs = [ finalAttrs.deps ];
})
