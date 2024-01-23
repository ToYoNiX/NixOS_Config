{
  inputs,
  config,
  lib,
  pkgs,
  stylix,
  ...
}: {
  stylix = {
    polarity = "dark";
    image = inputs.wallpaper;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
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
