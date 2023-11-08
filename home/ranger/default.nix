{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.file.".config/ranger/rc.conf".source = ./rc.conf;
  home.packages = with pkgs; [
    ranger
    ueberzugpp
  ];
}
