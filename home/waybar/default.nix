{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.file.".config/waybar/style.css".source = ./style.css;
  programs.waybar = {
    enable = true;
    #style = ./style.css;
    settings = [./config.nix];
  };
}
