{ config, pkgs, ... }:

let
  fb-input = pkgs.callPackage "/home/mjhoy/dotfiles/nix/pkgs/fb-input/default.nix" {};
in {

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless.

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "lat9w-16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    git
    emacs
    vim
    firefox
    ruby
    offlineimap
    mu
    nix-repl
    unzip
  ];

  # Fonts
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts # Microsoft free fonts
      inconsolata
      source-code-pro
      ubuntu_font_family
      fb-input
    ];
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.nixosManual.showManual = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.kdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.windowManager.xmonad.enable = true;

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
