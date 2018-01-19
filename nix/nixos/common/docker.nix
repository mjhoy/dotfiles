{ config, pkgs, ... }:

{
  # This enables the docker daemon.
  # Don't start up until the socket is accessed.
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;
}
