{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    man-pages

    file
    unzip
    gnupg1
    gnumake
    silver-searcher
    tree

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
