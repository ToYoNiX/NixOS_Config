{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  networking.hostName = "desktop"; # Define your hostname.

  imports = [];

  # Home partition
  fileSystems."/home" = {
    device = "/dev/disk/by-label/HOME";
    fsType = "btrfs";
  };

  # Pass my dGpu
  boot.extraModprobeConfig = "options vfio-pci ids=10de:2507,10de:228e";
  boot.kernelParams = ["amd_iommu=on" "vfio-pci.ids=10de:2507,10de:228e"];
  boot.kernelModules = ["vfio" "vfio_pci" "vfio_iommu_type1" "vfio_virqfd"];
}
