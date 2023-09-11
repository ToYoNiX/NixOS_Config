{ ... }:

{
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/18c64501-1258-40df-9c33-75fc13096e56";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/CB71-D507";
      fsType = "vfat";
    };

  swapDevices = [ ];
}
