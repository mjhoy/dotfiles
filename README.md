# dotfiles

My configuration. Mostly used on OSX.

## Editor setup

Most of my work happens in Emacs. Config for programming languages, and
org-mode stuff lives in `emacs.d/`. I don't use vim so much these days and
have a minimal config, in `vim/`.

## Nix

As much as possible, I like to install software with `nix`.

I configure a global environment, `devEnv`, defined in
`nix/nixpkgs/config.nix`. The simple script `scripts/build-nix-env`
attempts to build and install this.

`nixpkgs/default.nix` is just a pointer to a pinned version of
nixpkgs, defined at `nix/sources.json`. This can be updated by running
`niv update nixpkgs` in the project root.

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

If everything is properly set up, nix should use the nixpkgs pinned at
`nixpkgs/default.nix`.

## License

MIT. See included LICENSE file.
