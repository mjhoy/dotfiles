{ config, pkgs, ... }:

let
  fb-input = pkgs.callPackage ./pkgs/fb-input {};
in {
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

  environment.systemPackages = with pkgs; [
    firefox
  ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";

  # Enable xfce/xmonad
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.windowManager.xmonad.enable = true;
}
