{ stdenv }:
stdenv.mkDerivation {
  name = "libmikey";
  src = ~/.dotfiles/src/libmikey;
  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/include
    cp build/include/* $out/include
    cp build/lib/* $out/lib
  '';
}
