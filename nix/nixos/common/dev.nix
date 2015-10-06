{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    file
    unzip

    # haskell
    ghc
    cabal-install
    cabal2nix
  ];
}
