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
    ruby
    bundix

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

    # imagemagick, often used in web dev
    imagemagick
  ];

  environment.shellInit = ''
    if [[ $TERM == dumb ]]; then
      PAGER=cat;
    fi
  '';
}
