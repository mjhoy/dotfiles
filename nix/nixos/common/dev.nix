{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    file
    unzip
    gnupg1

    # haskell
    ghc
    cabal-install
    cabal2nix
  ];
}
