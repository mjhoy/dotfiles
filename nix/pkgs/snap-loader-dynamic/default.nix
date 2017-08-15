{ mkDerivation, base, directory, directory-tree, hint, mtl
, snap-core, stdenv, template-haskell, time, unix
, fetchgit
}:
mkDerivation {
  pname = "snap-loader-dynamic";
  version = "1.0.0.0";
  src = fetchgit {
    url = "https://github.com/snapframework/snap-loader-dynamic.git";
    rev = "b4fae0f3356a09e83852a530c44d2caf6c3e0442";
    sha256 = "1h0hpb8zssh39jb03drr921b5xiqjamga8w4fyq1l2v9r292bgiw";
  };
  libraryHaskellDepends = [
    base directory directory-tree hint mtl snap-core template-haskell
    time unix
  ];
  homepage = "http://snapframework.com/";
  description = "Snap dynamic loader";
  license = stdenv.lib.licenses.bsd3;
}
