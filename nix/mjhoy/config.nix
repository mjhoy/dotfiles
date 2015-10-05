# symlink to ~/.nixpkgs/config.nix

{
  allowUnfree = true;

  # define a derivation i can install/update with
  #
  # $ nix-env -iA nixpkgs.myHaskellEnv
  packageOverrides = super: let self = super.pkgs; in with self; rec {
    haskellEnv = haskellPackages.ghcWithPackages (p: with p; [
      cabal-install
    ]);
  };
}
