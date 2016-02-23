{ config, pkgs, ... }:

{
  containers.postgresql = {
    config =
      { config, pkgs, ... }:
      {
        services.postgresql = {
          enable = true;
          package = pkgs.postgresql93;
          # trust users connecting over 127.0.0.1
          authentication = ''
            host all all 127.0.0.1/32 trust
          '';
        };
      };
  };
}
