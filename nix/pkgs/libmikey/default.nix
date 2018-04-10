{ stdenv }:
stdenv.mkDerivation {
  name = "libmikey";
  src = ~/.dotfiles/src/libmikey;
  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/include/mikey
    cp build/include/* $out/include/mikey
    cp build/lib/* $out/lib
  '';
}
