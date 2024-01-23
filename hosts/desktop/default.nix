{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  networking.hostName = "desktop"; # Define your hostname.

  imports = [
    # GPU mode
    ./dGPU/pass.nix
  ];

  # Home partition
  fileSystems."/home" = {
    device = "/dev/disk/by-label/HOME";
    fsType = "btrfs";
  };
}
