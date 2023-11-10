{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  stylix.targets.waybar.enableCenterBackColors = false;
  stylix.targets.waybar.enableLeftBackColors = false;
  stylix.targets.waybar.enableRightBackColors = false;
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [./config.nix];
  };
}
