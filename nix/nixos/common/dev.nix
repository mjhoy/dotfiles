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

    # postgres
    postgresql93

    # nix
    nix-repl
    strategoPackages.strategoxt # pp-aterm

    # haskell
    ghc
    cabal-install
    cabal2nix
  ];

  environment.shellInit = ''
    if [[ $TERM == dumb ]]; then
      PAGER=cat;
    fi
  '';
}
