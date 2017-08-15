{ mkDerivation, base, blaze-builder, blaze-html, blaze-markup
, bytestring, bytestring-builder, containers, directory, HUnit
, parsec, stdenv, test-framework, test-framework-hunit, text
, unordered-containers, hspec
, fetchgit
}:
mkDerivation {
  pname = "xmlhtml";
  version = "0.2.5";
  src = fetchgit {
    url = "https://github.com/snapframework/xmlhtml.git";
    rev = "67e030ca113d29b0b09b84a353d3b456ad457179";
    sha256 = "1l15xw12qc53q5vllds93qj22268zyf8shvn7ia9fwxwgiwjdfq8";
    fetchSubmodules = false;
  };
  libraryHaskellDepends = [
    base blaze-builder blaze-html blaze-markup bytestring
    bytestring-builder containers parsec text unordered-containers
  ];
  testHaskellDepends = [
    base blaze-builder blaze-html blaze-markup bytestring
    bytestring-builder directory HUnit test-framework
    test-framework-hunit text hspec
  ];
  homepage = "https://github.com/snapframework/xmlhtml";
  description = "XML parser and renderer with HTML 5 quirks mode";
  license = stdenv.lib.licenses.bsd3;
}
