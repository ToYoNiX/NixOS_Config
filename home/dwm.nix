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
      deluge &
      uget-gtk &
      nm-applet &
      discord &
      blueman-applet &
      udiskie --appindicator -t &
      sleep 5 && dwmblocks &
      exec dwm
    '';
  };

  home.file."/home/assem/scripts".source = ./../scripts;

  home.packages = with pkgs;
    [
      xclip
      xorg.libX11
      xorg.libxcb
      xorg.libXft
      xorg.xinit
      xorg.xinput
      xorg.libXinerama
    ]
    ++ [
      st
      dwm
      dmenu
      dwmBlocks
    ];
}
