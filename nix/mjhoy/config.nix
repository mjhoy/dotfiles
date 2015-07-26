# symlink to ~/.nixpkgs/config.nix

{
  allowUnfree = true;

  # define a derivation i can install/update with
  #
  # $ nix-env -iA nixpkgs.myHaskellEnv
  packageOverrides = super: let self = super.pkgs; in with self; rec {
    # haskell package overrides
    myHaskellPackages = hp: hp.override {
      overrides = self: super: with pkgs.haskell-ng.lib; {
        mockery = dontCheck super.mockery;
      };
    };

    haskell7101Packages = myHaskellPackages super.haskell-ng.packages.ghc7101;

    myHaskellEnv = buildEnv {
      name = "myHaskellEnv";
      paths = with haskell7101Packages; [
        ghc
        lens
        pandoc
      ];
    };
  };
}
