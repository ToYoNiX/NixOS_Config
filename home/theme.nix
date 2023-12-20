{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "ePapirus-Dark";
    };
  };
}
