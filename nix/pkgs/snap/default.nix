{ mkDerivation, aeson, async, attoparsec, base, bytestring, cereal
, clientsession, configurator, containers, deepseq, directory
, directory-tree, dlist, filepath, Glob, hashable, heist
, http-streams, HUnit, lens, lifted-base, map-syntax, monad-control
, mtl, mwc-random, pwstore-fast, QuickCheck, smallcheck, snap-core
, snap-server, stdenv, stm, syb, test-framework
, test-framework-hunit, test-framework-quickcheck2
, test-framework-smallcheck, text, time, transformers
, transformers-base, unordered-containers, xmlhtml
, fetchgit
}:
mkDerivation {
  pname = "snap";
  version = "1.0.0.1";
  src = fetchgit {
    rev = "b890d957d02c6fa8405c62b1e9632acf3235e3bb";
    sha256 = "11sb5z9i4y90075v1gsx7980r58x5kn4g1zrrbwnkd23hzziwa7z";
    url = "https://github.com/snapframework/snap.git";
    fetchSubmodules = false;
  };
  libraryHaskellDepends = [
    aeson attoparsec base bytestring cereal clientsession configurator
    containers directory directory-tree dlist filepath hashable heist
    lens lifted-base map-syntax monad-control mtl mwc-random
    pwstore-fast snap-core snap-server stm text time transformers
    transformers-base unordered-containers xmlhtml
  ];
  testHaskellDepends = [
    aeson async attoparsec base bytestring cereal clientsession
    configurator containers deepseq directory directory-tree dlist
    filepath Glob hashable heist http-streams HUnit lens lifted-base
    map-syntax monad-control mtl mwc-random pwstore-fast QuickCheck
    smallcheck snap-core snap-server stm syb test-framework
    test-framework-hunit test-framework-quickcheck2
    test-framework-smallcheck text time transformers transformers-base
    unordered-containers xmlhtml
  ];
  homepage = "http://snapframework.com/";
  description = "Top-level package for the Snap Web Framework";
  license = stdenv.lib.licenses.bsd3;
}
