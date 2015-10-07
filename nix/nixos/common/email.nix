{ config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    mu
    offlineimap
    aspell
    aspellDicts.en
    aspellDicts.es
  ];
}
