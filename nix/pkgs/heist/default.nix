{ mkDerivation, aeson, attoparsec, base, bifunctors, blaze-builder
, blaze-html, bytestring, containers, criterion, directory
, directory-tree, dlist, filepath, hashable, HUnit, lens
, lifted-base, map-syntax, monad-control, mtl, process, QuickCheck
, random, statistics, stdenv, test-framework, test-framework-hunit
, test-framework-quickcheck2, text, time, transformers
, transformers-base, unordered-containers, vector, xmlhtml
, pandoc
, fetchgit
}:
mkDerivation {
  pname = "heist";
  version = "1.0.1.0";
  src = fetchgit {
    url = "https://github.com/snapframework/heist.git";
    rev = "7731eb14a1537a69a24358b1b700362271bc88e6";
    sha256 = "15a7j7q4v5mba8a9v6x8rlvyhpcq62953b12syq9hc6aq28gkqyg";
    fetchSubmodules = false;
  };
  libraryHaskellDepends = [
    aeson attoparsec base blaze-builder blaze-html bytestring
    containers directory directory-tree dlist filepath hashable
    lifted-base map-syntax monad-control mtl process random text time
    transformers transformers-base unordered-containers vector xmlhtml
  ];
  testHaskellDepends = [
    aeson attoparsec base bifunctors blaze-builder blaze-html
    bytestring containers directory directory-tree dlist filepath
    hashable HUnit lens lifted-base map-syntax monad-control mtl
    process QuickCheck random test-framework test-framework-hunit
    test-framework-quickcheck2 text time transformers transformers-base
    unordered-containers vector xmlhtml pandoc
  ];
  benchmarkHaskellDepends = [
    aeson attoparsec base blaze-builder blaze-html bytestring
    containers criterion directory directory-tree dlist filepath
    hashable HUnit lifted-base map-syntax monad-control mtl process
    random statistics test-framework test-framework-hunit text time
    transformers transformers-base unordered-containers vector xmlhtml
  ];
  homepage = "http://snapframework.com/";
  description = "An Haskell template system supporting both HTML5 and XML";
  license = stdenv.lib.licenses.bsd3;
}
