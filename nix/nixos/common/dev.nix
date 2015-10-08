{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    file
    unzip
    gnupg1
    gnumake

    # nix
    nix-repl

    # haskell
    ghc
    cabal-install
    cabal2nix
  ];
}
