{ config, pkgs, ... }:

{
  # start ssh-agent when I log in.
  programs.ssh.startAgent = true;

  programs.gnupg.agent.enable = true;

  # TODO: look into getting keybase to work.
  # See https://github.com/NixOS/nixpkgs/pull/25610
  # services.kbfs.enable = true;
}
