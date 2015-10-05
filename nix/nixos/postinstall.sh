#!/bin/sh

set -e

nix-channel --add https://nixos.org/channels/nixos-unstable nixos

nix-channel --update nixos
nixos-rebuild switch

nix-collect-garbage -d

git clone https://github.com/mjhoy/dotfiles.git /home/mjhoy/dotfiles

chown -R mjhoy:users /home/mjhoy/dotfiles

ln -s /home/mjhoy/dotfiles/nix/nixos/common/ /etc/nixos/

cd /home/mjhoy
su - mjhoy -c /home/mjhoy/dotfiles/install
su - mjhoy "git config --global user.name 'Michael Hoy'"
su - mjhoy "git config --global user.email 'mjh@mjhoy.com'"
