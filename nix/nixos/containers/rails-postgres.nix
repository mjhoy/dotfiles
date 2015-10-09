{ config, pkgs, ... }:

{
  # wip...
  containers.railsApp = {
    config =
      { config, pkgs, ... }:
      {
        services.postgresql.enable = true;
        services.postgresql.package = pkgs.postgresql93;
      };
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";
  };
}
