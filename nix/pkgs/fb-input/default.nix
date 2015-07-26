/*
  Please understand and agree to the terms here
  if you are going to use this:
  http://input.fontbureau.com/download
*/

{ stdenv, fetchurl }:

stdenv.mkDerivation {
  name = "fb-input-1.0.0";
  src = fetchurl {
    url = "https://dl.dropboxusercontent.com/u/2239902/input_fonts.tar.gz";
    md5 = "3bb98b286c2c8206f8957384ef520eda";
  };

  phases = "unpackPhase installPhase";

  installPhase = let
    fonts_dir = "$out/share/fonts";
  in ''
    mkdir -pv ${fonts_dir}
    find . -name "*.ttf" -exec cp {} ${fonts_dir} \;
  '';

  meta = {
    homepage = "http://input.fontbureau.com/";
    description = "Input font";
  };
}
