{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./guest.nix
  ];

  # we always want git and vim
  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  networking.hostName = "nixos";
  networking.hostId = "adbb8c40";

  services.openssh.enable = true;

  # Enable the X11 windowing system.
  #  services.xserver.enable = true;
  #  services.xserver.layout = "us";
  ## services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.kdm.enable = true;
  # services.xserver.desktopManager.xfce.enable = true;
  # services.xserver.windowManager.xmonad.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };
  users.extraUsers.mjhoy = {
    isNormalUser = true;
    home = "/home/mjhoy";
    description = "Michael Hoy";
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
