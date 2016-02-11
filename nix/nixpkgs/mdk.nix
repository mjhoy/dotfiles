{ stdenv, fetchurl, intltool, pkgconfig, glib }:

stdenv.mkDerivation {
  name = "gnu-mdk-1.2.9";
  src = fetchurl {
    url = http://ftp.gnu.org/gnu/mdk/v1.2.9/mdk-1.2.9.tar.gz;
    md5 = "08c96baa4b99dd9d25190dd15fe415a5";
  };
  buildInputs = [ intltool pkgconfig glib ];
  postInstall = ''
    mkdir -p $out/share/emacs/site-lisp/
    cp -v ./misc/*.el $out/share/emacs/site-lisp
  '';
}
