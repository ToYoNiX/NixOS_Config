{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  dwm = pkgs.dwm.overrideAttrs (old: {
    src = inputs.dwm;
  });
  st = pkgs.st.overrideAttrs (old: {
    src = inputs.st;
  });
  dmenu = pkgs.dmenu.overrideAttrs (old: {
    src = inputs.dmenu;
  });
  dwmBlocks = pkgs.dwmblocks.overrideAttrs (old: {
    src = inputs.dwmBlocks;
  });
in {
  home.file."/home/assem/.WM" = {
    executable = true;
    text = ''
      exec dwm &
      nm-applet &
      discord &
      blueman-applet &
      udiskie --appindicator -t &
      dwmblocks
    '';
  };

  home.packages = [
    st
    dwm
    dmenu
    dwmBlocks
  ];
}
