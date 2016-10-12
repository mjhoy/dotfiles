{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    htop

    man-pages

    file
    unzip
    gnupg1
    gnumake
    silver-searcher
    tree
    nethogs

    python

    # postgres
    postgresql93

    # nix
    nix-repl

    # haskell
    ghc
    cabal-install
    cabal2nix

    # standard tools
    clang
  ];

  environment.shellInit = ''
    if [[ $TERM == dumb ]]; then
      PAGER=cat;
    fi
  '';
}
