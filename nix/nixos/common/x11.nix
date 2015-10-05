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
  services.xserver = {
    enable = true;
    layout = "us";

    # Enable kde
    desktopManager.kde4.enable = true;
    displayManager.kdm.enable = true;

    # xmonad... maybe later!
    # windowManager.xmonad.enable = true;
    # windowManager.default = "xmonad";
  };


}
