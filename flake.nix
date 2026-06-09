{
  description = "mjhoy's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
  };

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ (import ./nix/overlays) ];
      };
    in {
      overlays.default = import ./nix/overlays;

      packages.${system} = let
        devEnv = pkgs.buildEnv {
          name = "devEnv";
          paths = import ./nix/packages.nix pkgs;
        };
      in {
        inherit devEnv;
        default = devEnv;
      };
    };
}
