final: prev:
prev.scalafmt.overrideAttrs (finalAttrs: prevAttrs: {
  version = "3.10.7";
  deps = prev.stdenv.mkDerivation {
    name = "${prevAttrs.pname}-deps-3.10.7";
    buildCommand = ''
      export COURSIER_CACHE=$(pwd)
      ${prev.coursier}/bin/cs fetch org.scalameta:scalafmt-cli_2.13:3.10.7 > deps
      mkdir -p $out/share/java
      cp $(< deps) $out/share/java/
    '';
    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = "sha256-egN5P6jH/xvWm/5TXE/QyIyLdJqu8YQwkfIA40geRXs=";
  };
  buildInputs = [ finalAttrs.deps ];
})
