# Acer C720-specific configuration.
#
# Current issues: none! Running on a recent linux kernel (>= 4.4)
# seems to have solved a lot.
#
# To do:
#
#   - udev rule to automatically set up external monitor when HDMI is
#     plugged in
#
# some config taken from
# https://github.com/henrytill/etc-nixos/blob/master/machines/thaumas.nix
{ config, pkgs, ...}:

{
  # Asus C720 suspend compat
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

  # Ignore the power key for now.
  #
  # To suspend, instead run: systemctl suspend, or systemctl
  # hibernate, etc.
  #
  # See more at logind.conf(5)
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=ignore
  '';

  # Touchpad configuration.
  services.xserver.synaptics = {
    enable = true;
    maxSpeed = "4.0";
    twoFingerScroll = true;
    tapButtons = false;
    palmDetect = true;
    additionalOptions = ''
      Option "FingerLow" "10"
      Option "FingerHigh" "10"
      Option "BottomEdge" "400"
      Option "AreaBottomEdge" "400"
      Option "VertScrollDelta" "-61"
      Option "HorizScrollDelta" "-31"
    '';
  };

  # maybe this is needed?
  hardware.opengl.extraPackages = with pkgs; [ vaapiIntel ];
}
