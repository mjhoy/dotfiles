{ config, pkgs, ... }:

# Lenovo Thinkpad T440P-specific things to go here.
{
  # We have a trackpad.
  # Enable it.
  services.xserver.synaptics.enable = true;
}
