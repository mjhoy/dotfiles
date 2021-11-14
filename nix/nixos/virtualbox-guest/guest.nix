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

  # example: mount a VirtualBox shared folder
  # in VirtualBox, this folder would be called "mail"
  # the options set up the fs as readonly (ro) and as
  # owned by my user account.
  #
  # fileSystems."/home/mjhoy/.mail" = {
  #   fsType = "vboxsf";
  #   device = "mail";
  #   options = "ro,uid=1000,gid=100";
  # };
}
