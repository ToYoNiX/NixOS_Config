{
  inputs,
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  networking.hostName = "laptop"; # Define your hostname.

  # Enables support for Bluetooth
  hardware.bluetooth.enable = true;

  # Enable brightness control
  programs.light.enable = true;

  # Enable nixos power management
  powerManagement.enable = true;

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
