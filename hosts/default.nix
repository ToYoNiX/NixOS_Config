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
      ./configuration.nix
      stylix
    ];
    specialArgs = {inherit inputs outputs vars;};
  };

  # Laptop
  laptop = lib.nixosSystem {
    modules = [
      ./laptop
      ./configuration.nix
      stylix
    ];
    specialArgs = {inherit inputs outputs vars;};
  };
}
