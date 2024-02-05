{
  inputs,
  outputs,
  vars,
  config,
  lib,
  pkgs,
  stylix,
  ...
}: {
  stylix = {
    polarity = "dark";
    image = vars.wallpaper;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    fonts = {
      serif = {
        package = pkgs.nerdfonts;
        name = "FiraCode Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.nerdfonts;
        name = "FiraCode Nerd Font Mono";
      };
      monospace = {
        package = pkgs.nerdfonts;
        name = "FiraCode Nerd Font Mono";
      };
    };
  };
}
