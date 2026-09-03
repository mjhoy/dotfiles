{
  description = "mjhoy's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    emacs31.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, emacs31 }:
    let
      system = "aarch64-darwin";
      nixpkgsConfig = { allowUnfree = true; };
      basePkgs = import nixpkgs {
        inherit system;
        config = nixpkgsConfig;
        overlays = [ (import ./nix/overlays) ];
      };
      emacs31Pkgs = import emacs31 {
        inherit system;
        config = nixpkgsConfig;
      };
      myEmacs31 = import ./nix/overlays/emacs.nix {
        pkgs = emacs31Pkgs;
        emacs = emacs31Pkgs.emacs31;
      };
      pkgs = basePkgs.extend (_final: _prev: {
        # Keep the mu executable and its Emacs client on the same version.
        mu = emacs31Pkgs.mu;
        myEmacs = myEmacs31;
      });
    in {
      overlays.default = import ./nix/overlays;

      packages.${system} = let
        devEnv = pkgs.buildEnv {
          name = "devEnv";
          paths = import ./nix/packages.nix pkgs;
        };
      in {
        inherit devEnv;
        emacs30 = basePkgs.myEmacs;
        emacs31 = myEmacs31;
        default = devEnv;
      };
    };
}
