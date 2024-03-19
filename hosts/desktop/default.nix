{
  inputs,
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  networking.hostName = "desktop"; # Define your hostname.

  # Home partition
  fileSystems."/home" = {
    device = "/dev/disk/by-label/HOME";
    fsType = "btrfs";
  };

  imports = [
    # GPU state
    ./gpu/pass.nix
  ];
}
