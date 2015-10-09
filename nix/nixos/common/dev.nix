{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    file
    unzip
    gnupg1
    gnumake
    silver-searcher

    # nix
    nix-repl
    strategoPackages.strategoxt # pp-aterm

    # haskell
    ghc
    cabal-install
    cabal2nix

    # rails
    ruby_2_1_1
  ];
}
