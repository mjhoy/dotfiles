# Acer C720-specific configuration.
#
# Unfortunately things are not working quite yet. Suspend/resume
# causes some sort of weird USB error to fill up the system logs, and
# I have to force shut the computer down. I am hopefull I'll get it
# working eventually, apparently it has been done.
#
# The trackpad works, but is -- touchy. If I brush it at all, it
# clicks or does something silly. I have to build the kernel with a
# custom flag set for it to work at all.
#
# I would like the power button not to immediately shut the computer
# down without any warning when I am, say, working in emacs and trying
# to hit the backspace key. (Perhaps this is an xmonad config thing.)

{ config, pkgs, ...}:

{

  # Asus C720 suspend compat -- doesn't seem to work.
  boot.blacklistedKernelModules = [ "ehci_pci" ];
  boot.kernelParams = [
    "tpm_tis.interrupts=0"
    "i915.enable_ips=0"
  ];

  # Get sound working.
  # (disable the first intel sound card, enable the second.)
  boot.extraModprobeConfig = ''
    options snd_hda_intel enable=0,1
  '';

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "conservative";

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
  nixpkgs.config = {
    packageOverrides = super: let self = super.pkgs; in rec {
      stdenv = super.stdenv // {
        platform = super.stdenv.platform // {
          kernelExtraConfig = ''
            CHROME_PLATFORMS y
          '';
        };
      };
    };
  };

  # maybe this is needed?
  services.xserver.vaapiDrivers = [ pkgs.vaapiIntel ];
}
