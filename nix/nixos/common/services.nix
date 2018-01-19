{ config, pkgs, ... }:

{
  # start ssh-agent when I log in.
  programs.ssh.startAgent = true;

  programs.gnupg.agent.enable = true;
}
