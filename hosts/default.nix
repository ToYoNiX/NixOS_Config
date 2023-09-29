{
  inputs,
  outputs,
  vars,
  lib,
  ...
}: {
  # Desktop
  desktop = lib.nixosSystem {
    modules = [
      ./desktop
      ./configuration.nix
    ];
    specialArgs = {inherit inputs outputs vars;};
  };

  # Laptop
  laptop = lib.nixosSystem {
    modules = [
      ./laptop
      ./configuration.nix
    ];
    specialArgs = {inherit inputs outputs vars;};
  };
}
