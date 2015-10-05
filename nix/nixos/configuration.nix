{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./guest.nix
    # ./common/x11.nix
  ];

  # essential packages
  environment.systemPackages = with pkgs; [
    git
    vim
    emacs
    htop
  ];

  # hello from MN
  time.timeZone = "America/Chicago";

  networking.hostName = "nixos";
  networking.hostId = "adbb8c40";

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";

  users.extraUsers.mjhoy = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/mjhoy";
    description = "Michael Hoy";
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCzSLtCpuVPZJrCbDgFDgKAOTdUtZR7M95x4bRCFHAp3gBXQnSIqAnrK/0RsfUQmzdAqGDPlBCz8tEG9s5WaD1bZR4r7m2WCIbecMoKU7QstLQvHdy1ysxXQx9pEDGTRlon1eMT4I1c575R7aIdKcIkc6yP/wLArPzzWxbCFGdwcXRnQcxTy7IjdKV3CF2viZyQWA/1GGXpGRs3aDKKSVlzp1otcoC+t0i880k40gc60xnra3N1gCEkh5Nw6LRU4IWfkw8wiA0WS+6FrYoZUZSZBVG4l1/QYW1B+eDftw/ez7Nt2OP+m1G6q9c2x4VFs4SN+HMOVRqNf/p1UiYURsVBB3SgCRC3RPiBUYcYBBZZXWc59UoKmg/dmS3pOHW1HywAiYpKP6pZ1LxrAmcG2jt/j2vgMO4NOfGNKzJKg5KQ93sFxJT/qkNwP5dt3+EKBdmZOykYQkD7OOBGTELiiUu5CtbNTJTQhgJyuwVFVC/wLm2+a0tnEBYPbJBCnYxqCmkQSzGvdJOXniyQu5+30OwyBFBpHIGqouFCf33JeY+vi4oi0XP0T9MJklJT9nSleHbB3xLOTODsRXS1jveB/OU9LA88N42GcWzrS1HYTrinSBugH8jUmtmupaDUGeWc0IJWO2qQRRNuhlZ130JBPWPFGd+SHFGidyma+4lJByaefw== mjh@mjhoy.com" ];
  };
}
