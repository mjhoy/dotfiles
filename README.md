# dotfiles

My configuration. Mostly used on OSX.

## Editor setup

Most of my work happens in Emacs. Config for programming languages, and
org-mode stuff lives in `emacs.d/`l. I don't use vim so much these days and
have a minimal config, in `vim/`.

I've started using vscode for scala, typescript, and rust code. My settings
are in `vscode/settings.json`.

## Nix

As much as possible, I like to install software with `nix`.

The `nixpkgs/` nixpkgs submodule is the specific commit I'm using nix from.
Currently it is tracking the `nixpkgs-20.03-darwin` branch. To update this, I
run the `scripts/bump-nixpkgs` script. I try to do this once a week.

My main config is at `nix/nixpkgs/config.nix`. This defines a nix attribute,
`devEnv`, which sets up my standard environment.

## Other stuff

There are some random projects in `src/`, and random notes in `notes/`.

## Installing

### Check out

```sh
git clone --recursive https://github.com/mjhoy/dotfiles.git
```

And then:

```sh
make install
```

sets up the symlinks.

### Nix

Follow the instructions here: https://nixos.org/download.html

On Mac OS Catalina, you can't make a `/nix` root-level directory. I followed
the instructions here:

https://github.com/NixOS/nix/issues/2925#issuecomment-539570232

I also use cachix for installing Haskell IDE packages. Installation
instructions here:

https://app.cachix.org/cache/all-hies

## License

MIT. See included LICENSE file.
