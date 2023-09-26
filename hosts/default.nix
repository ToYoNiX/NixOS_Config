{ inputs, outputs, nixpkgs, ... }:

let
  system = "x86_64-linux";                                  # System Architecture

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;                              # Allow Proprietary Software
  };

  lib = nixpkgs.lib;
in
{
  nixos = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs outputs;};
    # > Our main nixos configuration file <
    modules = [
        ./nixos/defaults.nix
    ];
  };
}