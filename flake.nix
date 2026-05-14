{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.pi = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./nix/configuration.nix
      ];
    };
  };
}
