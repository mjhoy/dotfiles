final: prev:
prev.metals.overrideAttrs (finalAttrs: prevAttrs: {
  version = "2.0.0-M16";
  deps = prev.stdenv.mkDerivation {
    name = "${prevAttrs.pname}-deps-2.0.0-M16";
    buildCommand = ''
      export COURSIER_CACHE=$(pwd)
      ${prev.coursier}/bin/cs fetch org.scalameta:metals_2.13:2.0.0-M16 \
        -r bintray:scalacenter/releases \
        -r sonatype:snapshots > deps
      mkdir -p $out/share/java
      cp $(< deps) $out/share/java/
    '';
    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = "sha256-XpWOhkvSndfZWFSnFT4yZb+aE97o+7r5hb1t9SqtNB0=";
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
