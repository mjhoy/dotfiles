# dotfiles

My configuration. Mostly used on OSX.

## Editor setup

Most of my work happens in Emacs. Config for programming languages, and
org-mode stuff lives in `emacs.d/`. I don't use vim so much these days and
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

### Nix setup

Follow the instructions here: https://nixos.org/download.html

On newer Mac OSes, you might need to tweak this to be able to get a
`/nix` directory. Check installation instructions here:

https://nixos.org/manual/nix/stable/#sect-macos-installation

I used the recommended approach:

```sh
curl -L https://nixos.org/nix/install | sh -s -- --darwin-use-unencrypted-nix-store-volume
```

One last step is to remove whatever channel was set up with in the
installation. I run:

```sh
nix-channel --list # note the channels listed
nix-channel --remove <channel> # whatever channels were listed
```

If everything is properly set up, nix should use the nixpkgs checked
out under dotfiles/nixpkgs.

## License

MIT. See included LICENSE file.
