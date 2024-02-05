{
  description = "Your new nix config";

  nixConfig = {
    extra-substituters = [
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";

    # Suckless utils
    suckless = {
      url = "github:ToYoNiX/suckless";
      flake = false;
    };

    # Official Hyprland Flake
    hyprland.url = "github:hyprwm/hyprland";

    # Stylix
    stylix.url = "github:danth/stylix";

    # Fixes OpenGL With Other Distros.
    nixgl.url = "github:guibou/nixGL";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;

    vars = {
      wallpaper = ./wallpapers/static/1.jpg;
    };

    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs vars;};
        modules = [
          # > Our main nixos configuration file <
          ./hosts/common
          ./hosts/desktop
          ./stylix
          inputs.stylix.nixosModules.stylix
        ];
      };

      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs vars;};
        modules = [
          # > Our main nixos configuration file <
          ./hosts/common
          ./hosts/laptop
          ./stylix
          inputs.stylix.nixosModules.stylix
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "assem@debian" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs vars;};
        modules = [
          # > Our main home-manager configuration file <
          ./home-manager/home.nix
          ./stylix
          inputs.stylix.homeManagerModules.stylix
        ];
      };
    };
  };
}
