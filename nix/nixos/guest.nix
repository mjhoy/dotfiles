{ config, pkgs, ... }:

#
# This file contains configuration specific to running OS as a virtualbox guest.
#

{
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  # VirtualBox: remove fsck that runs at startup
  boot.initrd.checkJournalingFS = false;

  virtualisation.virtualbox.guest.enable = true;
}
