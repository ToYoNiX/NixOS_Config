{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Enable brightness control
  programs.light.enable = true;

  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  # Enables support for Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable autocpu freq
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
}
