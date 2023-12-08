{
  description = "My nixos flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/";

    # The Uncompromising Nix Code Formatter
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";

    # NUR Community Packages -> Requires "nur.nixosModules.nur" to be added to the host modules
    nur.url = "github:nix-community/NUR";

    # Nix Helper
    nh.url = "github:viperml/nh";

    # Official Hyprland Flake
    hyprland.url = "github:hyprwm/hyprland";

    # Community scripts and utilities for Hypr projects
    hyprwm-contrib.url = "github:hyprwm/contrib";

    stylix.url = "github:danth/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;

    stylix = inputs.stylix.nixosModules.stylix;

    # Variables Used In Flake
    vars = {
      user = "assem";
      location = "$HOME/.setup";
      terminal = "foot";
    };

    lib = nixpkgs.lib // home-manager.lib;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = ( # NixOS Configurations
      import ./hosts {
        inherit inputs outputs stylix vars lib;
      }
    );

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    #homeConfigurations = {
    #  "assem@nixos" = home-manager.lib.homeManagerConfiguration {
    #    pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
    #    extraSpecialArgs = {inherit inputs outputs;};
    #    modules = [
    #      ./home/home.nix
    #    ];
    #  };
    #};
  };
}
