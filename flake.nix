{
  description = "My nixos flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/";

    # Styling the system
    stylix.url = "github:danth/stylix";

    dwm.url = "github:ToYoNiX/dwm";
    dwm.flake = false;

    st.url = "github:ToYoNiX/st";
    st.flake = false;

    dmenu.url = "github:ToYoNiX/dmenu";
    dmenu.flake = false;

    dwmBlocks.url = "github:ToYoNiX/dwmBlocks";
    dwmBlocks.flake = false;

    scripts.url = "github:ToYoNiX/scripts";
    scripts.flake = false;
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
      terminal = "st";
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
