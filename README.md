# dotfiles

My configuration. Mostly used on OSX.

## Editor setup

Most of my work happens in Emacs. Config for programming languages, and
org-mode stuff lives in `emacs.d/`. I don't use vim so much these days and
have a minimal config, in `vim/`.

## Nix

As much as possible, I like to install software with `nix`.

I use a flake to define my environment (`flake.nix`). More about how this is set
up at `nix/README.org`.

## Other stuff

There are some random projects in `src/`, and random notes in `notes/`.

## Installing

### Check out

```sh
git clone https://github.com/mjhoy/dotfiles.git
```

And then:

```sh
make install
```

sets up the symlinks.

### Nix setup

To build and install the dev environment:

```sh
nix profile install .#devEnv
```

To update nixpkgs and rebuild:

```sh
nix flake update
nix profile upgrade '.*'
```

## Emacs

I use `borg` for installing emacs packages, which adds them as submodules.
These live in `emacs.d/lib`.

To compile, run:

```sh
make -C emacs.d build
```

This can add some generated files which will show up in the git status and
are a bit annoying. You may want to run:

```sh
git config --local diff.ignoreSubmodules untracked
```

## License

MIT. See included LICENSE file.
