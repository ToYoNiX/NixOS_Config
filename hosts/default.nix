{
  inputs,
  outputs,
  stylix,
  vars,
  lib,
  ...
}: {
  # Desktop
  desktop = lib.nixosSystem {
    modules = [
      ./desktop
      ./common-configuration.nix
      ./common-hardware.nix
      stylix
    ];
    specialArgs = {inherit inputs outputs vars;};
  };

  # Laptop
  laptop = lib.nixosSystem {
    modules = [
      ./laptop
      ./common-configuration.nix
      ./common-hardware.nix
      stylix
    ];
    specialArgs = {inherit inputs outputs vars;};
  };
}
