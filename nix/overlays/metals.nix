final: prev:
let
  metalsVersion = "2.0.0-M18";
in
prev.metals.overrideAttrs (finalAttrs: prevAttrs: {
  version = metalsVersion;
  deps = prev.stdenv.mkDerivation {
    name = "${prevAttrs.pname}-deps-${metalsVersion}";
    buildCommand = ''
      export COURSIER_CACHE=$(pwd)
      ${prev.coursier}/bin/cs fetch org.scalameta:metals_2.13:${metalsVersion} \
        -r bintray:scalacenter/releases \
        -r sonatype:snapshots > deps
      mkdir -p $out/share/java
      cp $(< deps) $out/share/java/
    '';
    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = "sha256-ru8x1sMSkHelC4ZLSO7BcCbBNOp405ASqohyTOZMvbc=";
  };
  buildInputs = [ finalAttrs.deps ];

  # Metals 2 uses javac internals for indexing; without these exports JDK 21 will throw an IllegalAccessError.
  extraJavaOpts =
    prevAttrs.extraJavaOpts
    + " "
    + builtins.concatStringsSep " " [
      "--add-exports=jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED"
      "--add-exports=jdk.compiler/com.sun.tools.javac.code=ALL-UNNAMED"
      "--add-exports=jdk.compiler/com.sun.tools.javac.file=ALL-UNNAMED"
      "--add-exports=jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED"
      "--add-exports=jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED"
      "--add-exports=jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED"
    ];
})
