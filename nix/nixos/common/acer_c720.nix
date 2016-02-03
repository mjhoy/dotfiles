# Acer C720-specific configuration.
#
# Current issues:
#
#   - Suspend now does not cause a crazy amount of error messages to
#     go to the log; the problem now is that it immediately wakes up
#     after sleeping when I shut the lid.
#
#   - Therefore I'm using hibernate instead of suspend right now.
#
#   - Trackpad not working; I need to uncomment the linux config
#     below, I'm holding off on that because it means recompiling the
#     kernel.
#
# some config taken from
# https://github.com/henrytill/etc-nixos/blob/master/machines/thaumas.nix
{ config, pkgs, ...}:

{
  # Asus C720 suspend compat -- in progress!
  boot.kernelParams = [ "modprobe.blacklist=ehci_pci" ];

  # Get sound working.
  # (disable the first intel sound card, enable the second.)
  boot.extraModprobeConfig = ''
    options snd_hda_intel enable=0,1
  '';

  boot.cleanTmpDir = true;
  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "conservative";

  hardware.cpu.intel.updateMicrocode = true;

  # Use power key as a hibernate key. (Suspend is not working.) And
  # it's more useful (and safe) than power off, as I hit it by
  # accident a lot.
  services.logind.extraConfig = ''
    HandlePowerKey=hibernate
    HandleLidSwitch=hibernate
  '';

  # Touchpad configuration.
  services.xserver.synaptics = {
    enable = true;
    maxSpeed = "4.0";
    twoFingerScroll = true;
    additionalOptions = ''
      Option "FingerLow" "10"
      Option "FingerHigh" "10"
      Option "BottomEdge" "400"
      Option "AreaBottomEdge" "400"
      Option "VertScrollDelta" "-61"
      Option "HorizScrollDelta" "-31"
    '';
  };

  # set CHROME_PLATFORMS flag; needed for touchpad.
  # note: this means nix will need to build linux. fun!
  # nixpkgs.config = {
  #   packageOverrides = super: let self = super.pkgs; in rec {
  #     stdenv = super.stdenv // {
  #       platform = super.stdenv.platform // {
  #         kernelExtraConfig = ''
  #           CHROME_PLATFORMS y
  #         '';
  #       };
  #     };
  #   };
  # };

  # maybe this is needed?
  services.xserver.vaapiDrivers = [ pkgs.vaapiIntel ];
}
