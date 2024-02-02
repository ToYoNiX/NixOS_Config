{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  networking.hostName = "laptop"; # Define your hostname.
  # Enable brightness control
  programs.light.enable = true;

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
